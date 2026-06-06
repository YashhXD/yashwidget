import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class navBar extends StatelessWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onWorkPressed;
  final VoidCallback onExpPressed;
  const navBar({
    super.key,
    required this.onHomePressed,
    required this.onWorkPressed,
    required this.onExpPressed,
  });
  Future<void> _launchResume() async {
    final Uri url = Uri.parse('https://drive.google.com/file/d/1JmoMIW67p1lIGg7-_KmEVCxMZsVbpr9A/view?usp=sharing'); 
    
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
void _showSimpleDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Woah woah fellow vistor STEP BACK !!',style: TextStyle(fontFamily: 'SpaceB',fontSize: 20),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Construction is going on here',style: TextStyle(fontFamily: 'SpaceR',fontSize: 15),),
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
            child: const Text('Close',style: TextStyle(fontFamily: 'SpaceR',fontSize: 15),),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 200,
            width: 200,
            child: Image.asset('assets/logo.png'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
              TextButton(
                onPressed: () => _showSimpleDialog(context),
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