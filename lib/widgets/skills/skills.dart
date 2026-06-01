import 'package:flutter/material.dart';

class skillSection extends StatelessWidget {
  const skillSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
        child: const Column(
          children: [
            Text('My Work', 
            style: TextStyle(
              fontSize: 15,
            )),
          ],
        ),
      
    );
  }
}