import 'package:flutter/material.dart';
import 'package:auto_scrolling/auto_scrolling.dart'; // 1. IMPORT THE PACKAGE
import 'package:portfolio/widgets/centered_view/centered_view.dart';
import 'package:portfolio/widgets/course_details/course_details.dart';
import 'package:portfolio/widgets/nav_bar/nav.dart';
import 'package:portfolio/widgets/work/work.dart';
import 'package:portfolio/widgets/scroll/smooth_scroll_wrapper.dart'; 

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
        duration: const Duration(milliseconds: 800), 
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
          body: SmoothScrollWrapper(
            controller: _scrollController,
            scrollSpeed: 200.0, 
            animationDuration: 430, 
            // 2. WRAP THE CONTENT SEGMENT WITH AUTOSCROLL
            child: AutoScroll(
              controller: _scrollController, // Passes your shared controller
              deadZoneRadius: 12,           // Adjusts mouse movement sensitivity near the anchor point
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true, 
                trackVisibility: true, 
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const NeverScrollableScrollPhysics(), 
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
                          padding: EdgeInsets.only(top: 100,bottom: 150),
                          child: Text('Working in creative fields for over 6 years for numerous clients around the globe. \nAlways have been passionate about technology hence learning new technologies , \ncurrently I am facinated by Flutter which is why I created this whole website in dart language ontop of Flutter framework.',
                          style: TextStyle(fontSize: 17,
                          color: Color.fromARGB(255, 41, 37, 75),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'SpaceB',),)
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
      ),
    );
  }
}