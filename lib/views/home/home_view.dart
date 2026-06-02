import 'package:flutter/gestures.dart'; // Required for pointer signal interception
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart'; // Required for FrictionSimulation
import 'package:portfolio/widgets/centered_view/centered_view.dart';
import 'package:portfolio/widgets/course_details/course_details.dart';
import 'package:portfolio/widgets/nav_bar/nav.dart';
import 'package:portfolio/widgets/work/work1.dart';
import 'package:portfolio/widgets/work/work2.dart';
import 'package:portfolio/widgets/work/work3.dart';
import 'package:portfolio/widgets/skills/skills.dart';
import 'package:portfolio/widgets/workw/worked.dart';
import 'package:flutter/scheduler.dart';

// 1. The Mouse Wheel Accumulator (Tuned for smooth ease-in/ease-out)
class MouseWheelSmoothScroll extends StatefulWidget {
  final Widget child;
  final ScrollController controller;

  const MouseWheelSmoothScroll({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<MouseWheelSmoothScroll> createState() => _MouseWheelSmoothScrollState();
}

class _MouseWheelSmoothScrollState extends State<MouseWheelSmoothScroll> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _velocity = 0.0; 
  Duration _lastFrameTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
  }

  void _onTick(Duration elapsed) {
    if (!widget.controller.hasClients) return;

    if (_lastFrameTime == Duration.zero) {
      _lastFrameTime = elapsed;
      return;
    }

    final double dt = (elapsed - _lastFrameTime).inMilliseconds.toDouble() / 8;
    _lastFrameTime = elapsed;

    if (_velocity.abs() < 0.5) {
      _ticker.stop();
      _velocity = 0.0;
      _lastFrameTime = Duration.zero;
      return;
    }

    double newPosition = widget.controller.offset + (_velocity * dt  );

    newPosition = newPosition.clamp(
      widget.controller.position.minScrollExtent,
      widget.controller.position.maxScrollExtent,
    );

    // Light friction for a long ease-out glide
    _velocity *= 0.90; 

    if (newPosition == widget.controller.position.minScrollExtent ||
        newPosition == widget.controller.position.maxScrollExtent) {
      _velocity = 0.0;
    }

    widget.controller.jumpTo(newPosition);
  }

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      if (!widget.controller.hasClients) return;

      // Gentle push for a soft ease-in
      _velocity += event.scrollDelta.dy / 2  ;

      // THE FIX: Terminal Velocity Clamp prevents wild speed spikes
      _velocity = _velocity.clamp(-15.0, 15.0);

      if (!_ticker.isTicking) {
        _lastFrameTime = Duration.zero;
        _ticker.start();
      }
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _handlePointerSignal,
      child: widget.child,
    );
  }
}

// 2. Custom Native Physics (Makes trackpad and mobile swipes glide smoothly)
class SmoothGlidingScrollPhysics extends ScrollPhysics {
  const SmoothGlidingScrollPhysics({super.parent});

  @override
  SmoothGlidingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SmoothGlidingScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    if (velocity.abs() > 0) {
      return FrictionSimulation(
        0.01, 
        position.pixels,
        velocity,
      );
    }
    return super.createBallisticSimulation(position, velocity);
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _workKey = GlobalKey();
  final GlobalKey _expKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero, ancestor: context.findRenderObject());
      final currentOffset = _scrollController.offset;
      final targetOffset = position.dy + currentOffset;

      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 400), 
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: MouseWheelSmoothScroll(
            controller: _scrollController,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true, 
              trackVisibility: true, 
              interactive: true, 
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const SmoothGlidingScrollPhysics(
                  parent: BouncingScrollPhysics(), 
                ),
                child: CenteredView(
                  child: Column(
                    children: <Widget>[
                      navBar(
                        onHomePressed: () => _scrollToSection(_heroKey),
                        onWorkPressed: () => _scrollToSection(_workKey),
                        onExpPressed: () => _scrollToSection(_expKey),
                      ),
                      
                      Container(
                        key: _heroKey,
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const <Widget>[
                              Expanded(child: CourseDetails()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 350),
                      SizedBox(height: 50,key: _workKey,),
                      Container(
                        width: 1000,
                        child: Text('My Work',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                        fontSize: 70,
                        color: const Color.fromARGB(255, 236, 166, 174)
                          ),),
                      ),
                      SizedBox(height: 50),
                      Container(
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const <Widget>[
                              Expanded(child: WorkSection1()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 70,),
                      Container(
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const <Widget>[
                              Expanded(child: WorkSection2()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 70,),
                      Container(
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const <Widget>[
                              Expanded(child: WorkSection3()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 70,),
                      Container(
                        width: 1000,
                        child: Text('Skills',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                        fontSize: 70,
                        color: const Color.fromARGB(255, 236, 166, 174)
                          ),),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const <Widget>[
                              Expanded(child: skillSection()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      SizedBox(height: 40,key: _expKey),
                      Container(
                        width: 1000,
                        child: Text('Experience',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                        fontSize: 70,
                        color: const Color.fromARGB(255, 236, 166, 174)
                          ),),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const <Widget>[
                              Expanded(child: workedWith()),
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}