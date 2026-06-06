import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 180),
      width: 800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          SizedBox(height: 60,),
          Text(
            'I am \nYash Mehta',
            style: TextStyle(
              
              fontWeight: FontWeight.w800, 
              height: 1.1, 
              fontSize: 70, 
              color: Color.fromARGB(255, 24, 30, 62),
            ),
          ),
          SizedBox(height: 70,),
          Text(
            'Flutter Developer | Motion Graphic Designer | 3D Visual Artist',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 21, 
              height: 1.7, 
              color: Color.fromARGB(255, 41, 37, 75),
            ),
          )
        ],
      ),
    );
  }
}