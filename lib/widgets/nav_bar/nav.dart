import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portfolio/widgets/centered_view/centered_view.dart';
import 'package:url_launcher/url_launcher.dart';

class navBar extends StatelessWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onWorkPressed;
  final VoidCallback onExpPressed;
  final bool isScrolled;

  const navBar({
    super.key,
    required this.onHomePressed,
    required this.onWorkPressed,
    required this.onExpPressed,
    this.isScrolled = false,
  });

  Future<void> _launchResume() async {
    final Uri url = Uri.parse(
        'https://drive.google.com/file/d/1JmoMIW67p1lIGg7-_KmEVCxMZsVbpr9A/view?usp=sharing');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void _showSimpleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Woah woah fellow visitor STEP BACK !!',
            style: TextStyle(fontFamily: 'SpaceB', fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Construction is going on here',
                style: TextStyle(fontFamily: 'SpaceR', fontSize: 15),
              ),
              const SizedBox(height: 20),
              Image.network(
                'https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExMnIxbGtwdjhhOThuc2ozN3FidWl5NGVvbWF5c3U2bnZzbHhxYzMyMiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ZTans30ONaaIM/giphy.gif',
                height: 150,
                fit: BoxFit.contain,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Close',
                style: TextStyle(fontFamily: 'SpaceR', fontSize: 15),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double blurSigma = isScrolled ? 9.0 : 0.0;

    return CenteredView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: isScrolled
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: isScrolled
                      ? const Color(0xFF0A0E29).withValues(alpha: 0.45)
                      : Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 45,
                      child: Image.asset(
                        'assets/logo.webp',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _navItem('Home', onHomePressed),
                        const SizedBox(width: 24),
                        _navItem('Work', onWorkPressed),
                        const SizedBox(width: 24),
                        _navItem('Experience', onExpPressed),
                        const SizedBox(width: 24),
                        _navItem('Resume', _launchResume),
                        const SizedBox(width: 24),
                        _navItem(
                            'Shit Posting', () => _showSimpleDialog(context)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          color: Color.fromARGB(255, 226, 143, 201),
          fontSize: 16,
        ),
      ),
    );
  }
}