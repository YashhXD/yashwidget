import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Just a \nFlutter Dev', style: TextStyle(fontWeight: FontWeight.w800, height: 1.1, fontSize: 70, color: const Color.fromARGB(255, 24, 30, 62)),
          ),
          SizedBox(height: 30,),
          Text('This is an example text for the portfolio website using Flutter',style: TextStyle(fontSize: 21, height: 1.7, color:const Color.fromARGB(255, 58, 54, 107)),)

        ],
      ),

    );
  }
}