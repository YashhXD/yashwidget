import 'package:flutter/material.dart';

class CallToAction extends StatelessWidget {
  final String title;
  CallToAction(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      child: FilledButton(style: FilledButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 31, 229, 146),
        foregroundColor: Colors.black,
        minimumSize: const Size(150,50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )
      ),
      onPressed: () {
        print('Button pressed');
        }, 
        child: Text('Hell yeah' ,style: TextStyle(fontWeight:FontWeight.w400, fontSize: 17),)),
    );
  }
}