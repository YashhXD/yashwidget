import 'dart:ui';
import 'package:flutter/material.dart';

class workedWith1 extends StatelessWidget {
  const workedWith1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              // Transparent white tinted mix overlay
              color: const Color.fromARGB(40, 255, 255, 255),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- LEFT HAND SIDE: PROJECT IMAGE SCREEN ---
                
                const SizedBox(width: 32), // Gap between Image and Text elements

                // --- RIGHT HAND SIDE: CONTENT COLUMN ---
                Expanded(
                  flex: 6, // Takes up ~60% of horizontal space
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Studio 3',
                      style: TextStyle(
                        fontFamily: 'Alata',
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),),
                      // 1. Description Text
                      const Text(
                        'Worked as a motion graphic designer transforming raw footage into into engaging and intuitive motion graphic.',
                        style: TextStyle(
                          fontFamily: 'SpaceSB',
                          fontSize: 20,
                          fontWeight: FontWeight(600),
                          color: Color(0xFF1B1833), // Deep elegant indigo tone from image typography
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 2. Custom Bullet Points
                      const Text('Sept 25 - Feb 26, Remote', style: TextStyle( 
                        fontSize: 16,
                        fontFamily: 'Alata',

                      ),),
                      SizedBox(height: 10,),
                      _buildBulletPoint('Primarily used Adobe Premier Pro , After Effects and Photoshop'),
                      const SizedBox(height: 6),
                      _buildBulletPoint('Web asset for user comprehension'),
                      const SizedBox(height: 24),

                      // 3. Tech Stack Tags Row
                      Wrap(
                        spacing: 12, // Gap between chips horizontally
                        runSpacing: 8, // Gap if chips wrap to next line
                        children: [
                          _buildTechChip('Adobe After Effects'),
                          _buildTechChip('Adobe Premier Pro'),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5, // Takes up ~40% of horizontal space
                  child: AspectRatio(
                    aspectRatio: 4 / 3, // Maintains a clean desktop/monitor display ratio
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/work_asset/studio3.png', // Sample placeholder link
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper builder widget to construct aligned bullet configurations
  // FIX: Added optional curly braces {} parameter to accept custom styling overrides
  Widget _buildBulletPoint(String text, {TextStyle? customStyle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0, right: 8.0, left: 4.0),
          child: Icon(Icons.circle, size: 6, color: Color(0xFF1B1833)),
        ),
        Expanded(
          child: Text(
            text,
            // Fallback syntax: If customStyle is passed, it uses it; otherwise defaults to original styling
            style: customStyle ?? const TextStyle(
              fontFamily: 'SpaceSB',
              fontSize: 18, 
              color: Color(0xFF1B1833),
            ),
          ),
        ),
      ],
    );
  }

  // Helper builder widget to construct clean rounded boundary tags
  Widget _buildTechChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1B1833).withOpacity(0.4)),
        color: Colors.transparent,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'SpaceSB',
          fontSize: 16,
          color: Color(0xFF1B1833),
        ),
      ),
    );
  }
}