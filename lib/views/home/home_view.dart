import 'package:flutter/material.dart';
import 'package:portfolio/widgets/call_to_action/call_to_action.dart';
import 'package:portfolio/widgets/centered_view/centered_view.dart';
import 'package:portfolio/widgets/course_details/course_details.dart';
import 'package:portfolio/widgets/nav_bar/nav.dart';

class HomeView extends StatelessWidget{

  @override
  Widget build (BuildContext context){
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
        body: CenteredView(child: Column(children: <Widget>[navBar(),
        Expanded(child: Row(children: <Widget>[
          CourseDetails(),
        ],))
        ],)),
      
      ),
      )
    );
  }
}