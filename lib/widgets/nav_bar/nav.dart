import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class navBar extends StatelessWidget {
  // 1. Define the launch function inside the class
  Future<void> _launchResume() async {
    // Replace with your open-access Credly or Drive link
    final Uri url = Uri.parse('https://drive.google.com/file/d/1JmoMIW67p1lIGg7-_KmEVCxMZsVbpr9A/view?usp=sharing'); 
    
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              // 2. Link the function to the Resume button
              TextButton(
                onPressed: _launchResume, 
                child: Text(
                  'Resume',
                  style: TextStyle(
                    color: Color.fromARGB(255, 226, 143, 201),
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () { print('Shit Posting pressed'); },
                child: Text(
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