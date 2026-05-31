import 'package:flutter/gestures.dart'; // Required for pointer signal interception
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart'; // Required for FrictionSimulation
import 'package:portfolio/widgets/centered_view/centered_view.dart';
import 'package:portfolio/widgets/course_details/course_details.dart';
import 'package:portfolio/widgets/nav_bar/nav.dart';
import 'package:portfolio/widgets/work/work.dart';
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

    final double dt = (elapsed - _lastFrameTime).inMilliseconds.toDouble() / 5;
    _lastFrameTime = elapsed;

    if (_velocity.abs() < 0.5) {
      _ticker.stop();
      _velocity = 0.0;
      _lastFrameTime = Duration.zero;
      return;
    }

    double newPosition = widget.controller.offset + (_velocity * dt);

    newPosition = newPosition.clamp(
      widget.controller.position.minScrollExtent,
      widget.controller.position.maxScrollExtent,
    );

    // Light friction for a long ease-out glide
    _velocity *= 0.92; 

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
      _velocity += event.scrollDelta.dy / 2 ;

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
  final GlobalKey _workKey1 = GlobalKey();

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
                      Container(
                        padding: const EdgeInsets.only(top: 100, bottom: 150),
                        child: const Text(
                          'Working in creative fields for over 6 years for numerous clients around the globe. \nAlways have been passionate about technology hence learning new technologies , \ncurrently I am facinated by Flutter which is why I created this whole website in dart language ontop of Flutter framework.',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 41, 37, 75),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SpaceB',
                          ),
                        ),
                      ),
                      Container(
                        key: _workKey1,
                        child: const WorkSection(), 
                      ),
                      Container(
                        key: _workKey,
                        child: const WorkSection(), 
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