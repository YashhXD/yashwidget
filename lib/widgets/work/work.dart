// work.dart
import 'dart:ui';

import 'package:flutter/material.dart';

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a Container with a media query makes it self-contained and responsive
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.8, // Takes up 80% of screen height
      
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(41, 255, 255, 255)),
                    color: const Color.fromARGB(61, 255, 248, 225),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}