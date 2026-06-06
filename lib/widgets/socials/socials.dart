import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class socialInfo extends StatelessWidget {
  const socialInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Get ',style: TextStyle(
              fontSize: 35,
              fontFamily: 'WorkSansB',
              fontWeight: FontWeight.w600,
              color: const Color(0xFF5B438A),
            ),),
              Text('in Touch .',style: TextStyle(
              fontSize: 35,
              fontFamily: 'WorkSansB',
              fontWeight: FontWeight.w600,
              color: Color(0xFF182042),
              
            ),),
            ]
          ),
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 60,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.github),
                iconSize: 30,
                color: Color.fromARGB(255, 41, 42, 90),
                onPressed: () async {
                  final Uri url = Uri.parse('https://github.com/YashhXD');
                  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.linkedin),
                iconSize: 30,
                color: Color.fromARGB(255, 41, 42, 90),
                onPressed: () async {
                  final Uri url = Uri.parse('https://www.linkedin.com/in/yash37/');
                  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.instagram),
                iconSize: 30,
                color: Color.fromARGB(255, 41, 42, 90),
                onPressed: () async {
                  final Uri url = Uri.parse('https://www.instagram.com/da.yash.em/');
                  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}