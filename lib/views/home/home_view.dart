import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:portfolio/widgets/centered_view/centered_view.dart';
import 'package:portfolio/widgets/course_details/course_details.dart';
import 'package:portfolio/widgets/nav_bar/nav.dart';
import 'package:portfolio/widgets/work/work1.dart';
import 'package:portfolio/widgets/work/work2.dart';
import 'package:portfolio/widgets/work/work3.dart';
import 'package:portfolio/widgets/skills/skills.dart';
import 'package:portfolio/widgets/workw/worked1.dart';
import 'package:portfolio/widgets/workw/worked2.dart';
import 'package:portfolio/widgets/socials/socials.dart';
import 'package:flutter/scheduler.dart';

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

class _MouseWheelSmoothScrollState extends State<MouseWheelSmoothScroll>
    with SingleTickerProviderStateMixin {
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

    double newPosition = widget.controller.offset + (_velocity * dt);

    newPosition = newPosition.clamp(
      widget.controller.position.minScrollExtent,
      widget.controller.position.maxScrollExtent,
    );

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

      _velocity += event.scrollDelta.dy / 2;

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

class SmoothGlidingScrollPhysics extends ScrollPhysics {
  const SmoothGlidingScrollPhysics({super.parent});

  @override
  SmoothGlidingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SmoothGlidingScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
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
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final bool shouldBlur = _scrollController.offset > 20;
    if (shouldBlur != _isScrolled) {
      setState(() {
        _isScrolled = shouldBlur;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  void _scrollToSection(GlobalKey key) {
    final RenderBox? renderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero,
          ancestor: context.findRenderObject());
      final currentOffset = _scrollController.offset;
      final targetOffset = (position.dy + currentOffset - 90).clamp(
        _scrollController.position.minScrollExtent,
        _scrollController.position.maxScrollExtent,
      );

      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/back.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: MouseWheelSmoothScroll(
            controller: _scrollController,
            child: Stack(
              children: [
                Scrollbar(
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
                          const SizedBox(height: 100),
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
                          const SizedBox(height: 350),
                          SizedBox(height: 50, key: _workKey),
                          Container(
                            width: 1000,
                            child: const Text(
                              'Work',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 70,
                                color: Color.fromARGB(255, 236, 166, 174),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
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
                          const SizedBox(height: 70),
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
                          const SizedBox(height: 70),
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
                          const SizedBox(height: 70),
                          Container(
                            width: 1000,
                            child: const Text(
                              'Skills',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 70,
                                color: Color.fromARGB(255, 236, 166, 174),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
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
                          const SizedBox(height: 30),
                          SizedBox(height: 40, key: _expKey),
                          Container(
                            width: 1000,
                            child: const Text(
                              'Experience',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 70,
                                color: Color.fromARGB(255, 236, 166, 174),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: const <Widget>[
                                  Expanded(child: workedWith1()),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: const <Widget>[
                                  Expanded(child: workedWith2()),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: const <Widget>[
                                  Expanded(child: socialInfo()),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 70),
                          Container(
                            width: double.infinity,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xFF292A5A),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Yash Mehta',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 16,
                                    fontFamily: 'Alata',
                                  ),
                                ),
                                Text(
                                  'Made with lots of love and coffee 💛',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 14,
                                    fontFamily: 'Alata',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: navBar(
                    isScrolled: _isScrolled,
                    onHomePressed: _scrollToTop,
                    onWorkPressed: () => _scrollToSection(_workKey),
                    onExpPressed: () => _scrollToSection(_expKey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}