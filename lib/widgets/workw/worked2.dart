import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class workedWith2 extends StatelessWidget {
  const workedWith2({super.key});

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
              color: const Color.fromARGB(40, 255, 255, 255),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const SizedBox(width: 32),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Harshvardhan',
                      style: TextStyle(
                        fontFamily: 'Alata',
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),),
                      const Text(
                        'Professional video editor for enhancing raw gameplay footages into audience retaining and entertaining youtube videos.',
                        style: TextStyle(
                          fontFamily: 'SpaceSB',
                          fontSize: 20,
                          fontWeight: FontWeight(600),
                          color: Color(0xFF1B1833),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('May 25 - Present, Remote', style: TextStyle( 
                        fontSize: 16,
                        fontFamily: 'Alata',

                      ),),
                      SizedBox(height: 10,),
                      _buildBulletPoint('Made use of Premier Pro and After Effects for long form videos.'),
                      const SizedBox(height: 6),
                      _buildBulletPoint('Added 3D elements using Blender creating immersive experience.'),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          _buildTechChip('Adobe After Effects'),
                          _buildTechChip('Adobe Premier Pro'),
                          _buildTechChip('Blender'),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                              final Uri repoUrl = Uri.parse('https://www.youtube.com/@Lucius_Fr');
                              if (!await launchUrl(repoUrl, mode: LaunchMode.externalApplication)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Something went wrong, we are gonna work on it')),
                                );
                              }
                          },
                          icon: const Icon(Icons.code_rounded, size: 18, color: Colors.white),
                          label: const Text(
                            'View Channel',
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
                Expanded(
                  flex: 4,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/work_asset/harsh.png',
                        fit: BoxFit.fitHeight,
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