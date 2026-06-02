import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkSection3 extends StatelessWidget {
  const WorkSection3({super.key});

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
                Expanded(
                  flex: 4, // Takes up ~40% of horizontal space
                  child: AspectRatio(
                    aspectRatio: 4 / 3, // Maintains a clean desktop/monitor display ratio
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/work_asset/soundboard.png"),
                    ),
                  ),
                ),
                
                const SizedBox(width: 32), // Gap between Image and Text elements

                // --- RIGHT HAND SIDE: CONTENT COLUMN ---
                Expanded(
                  flex: 6, // Takes up ~60% of horizontal space
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('SoundBoard App',
                      style: TextStyle(
                        fontFamily: 'Meringue',
                        fontSize: 30,
                        fontWeight: FontWeight(800)
                      ),),
                      // 1. Description Text
                      const Text(
                        'Developed a SoundBoard app which can play various sounds straight from the click of a button, a practise application for learning and implementing Flutter framework.',
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
                      _buildBulletPoint('Based on Dart language developed by Google.'),
                      const SizedBox(height: 6),
                      _buildBulletPoint('Based on Dart language developed by Google.'),
                      const SizedBox(height: 6),
                      _buildBulletPoint('Works locally requiring no internet connectivity.'),
                      const SizedBox(height: 6),
                      _buildBulletPoint('Beta version is published and further feature about to roll out.'),
                      const SizedBox(height: 24),

                      // 3. Tech Stack Tags Row
                      Wrap(
                        spacing: 12, // Gap between chips horizontally
                        runSpacing: 8, // Gap if chips wrap to next line
                        children: [
                          _buildTechChip('Dart'),
                          _buildTechChip('Flutter'),
                          _buildTechChip('App Dev'),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // 4. GitHub View Project Button aligned to the bottom-right
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                              // 2. Parse your GitHub link into a valid Uri object
                              final Uri repoUrl = Uri.parse('https://github.com/YashhXD/SoundBoard-app');

                              // 3. Check if the device can open the URL, then launch it
                              if (!await launchUrl(repoUrl, mode: LaunchMode.externalApplication)) {
                                // Optional: Show an error snackbar if the link fails to open
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Something went wrong, we are gonna work on it')),
                                );
                              }
                          },
                          icon: const Icon(Icons.code_rounded, size: 18, color: Colors.white), // Standard icon fallback
                          label: const Text(
                            'View Project',
                            style: TextStyle(
                              fontFamily: 'SpaceSB',
                              fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
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