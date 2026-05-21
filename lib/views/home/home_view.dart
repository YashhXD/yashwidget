import 'package:flutter/material.dart';
import 'package:portfolio/widgets/centered_view/centered_view.dart';
import 'package:portfolio/widgets/course_details/course_details.dart';
import 'package:portfolio/widgets/nav_bar/nav.dart';
import 'package:portfolio/widgets/work/work.dart';
import 'package:portfolio/widgets/scroll/smooth_scroll_wrapper.dart'; // Import your new wrapper

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
        duration: const Duration(milliseconds: 800), // Nav click animation speed
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
          body: CenteredView(
            // --- ENTIRE WEBSITE GLOBAL SMOOTH SCROLL ACTIVATED HERE ---
            child: SmoothScrollWrapper(
              controller: _scrollController,
              scrollSpeed: 200.0, // Tweak this value to make wheel scrolling faster/slower
              animationDuration: 430, // Tweak this value to make wheel scrolling softer/snappier
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const NeverScrollableScrollPhysics(), // Disables default rigid web scrolling
                child: Column(
                  children: <Widget>[
                    navBar(
                      onHomePressed: () => _scrollToSection(_heroKey),
                      onWorkPressed: () => _scrollToSection(_workKey),
                    ),
                    
                    // Section 1: Hero
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
    );
  }
}