import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// FIX: Renamed class to capital 'NavBar' to resolve the "method not defined" error
class navBar extends StatelessWidget {
  // Declare the scroll callbacks needed by home_view.dart
  final VoidCallback onHomePressed;
  final VoidCallback onWorkPressed;
  final VoidCallback onExpPressed;

  // Add the callbacks to your constructor
  const navBar({
    super.key,
    required this.onHomePressed,
    required this.onWorkPressed,
    required this.onExpPressed,
  });

  // Your URL launcher logic for the resume remains perfectly intact
  Future<void> _launchResume() async {
    final Uri url = Uri.parse('https://drive.google.com/file/d/1JmoMIW67p1lIGg7-_KmEVCxMZsVbpr9A/view?usp=sharing'); 
    
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Your portfolio logo
          SizedBox(
            height: 200,
            width: 200,
            child: Image.asset('assets/logo.png'),
          ),
          
          // Navigation links container
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // --- BUTTON 1: HOME (Smooth Scroll) ---
              TextButton(
                onPressed: onHomePressed, 
                child: const Text(
                  'Home',
                  style: TextStyle(
                    color: Color.fromARGB(255, 226, 143, 201),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 30),
              TextButton(
                onPressed: onWorkPressed, 
                child: const Text(
                  'Work',
                  style: TextStyle(
                    color: Color.fromARGB(255, 226, 143, 201),
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(width: 30),

              TextButton(
                onPressed: onExpPressed,
                child: const Text(
                  'Experience',
                  style: TextStyle(
                    color: Color.fromARGB(255, 226, 143, 201),
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(width: 30),

              // --- BUTTON 3: RESUME (External URL Link) ---
              TextButton(
                onPressed: _launchResume, 
                child: const Text(
                  'Resume',
                  style: TextStyle(
                    color: Color.fromARGB(255, 226, 143, 201),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 30),

              // --- BUTTON 4: SHIT POSTING (Console log placeholder) ---
              TextButton(
                onPressed: () { debugPrint('Shit Posting pressed'); },
                child: const Text(
                  'Shit Posting',
                  style: TextStyle(
                    color: Color.fromARGB(255, 226, 143, 201),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}