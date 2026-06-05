import 'package:flutter/material.dart';
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
              fontWeight: FontWeight.w900,
              color: const Color(0xFF5B438A),
            ),),
              Text('in Touch .',style: TextStyle(
              fontSize: 35,
              fontFamily: 'WorkSansB',
              fontWeight: FontWeight.w900,
              color: Color(0xFF182042),
              
            ),),
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.apple),
              FaIcon(
  FontAwesomeIcons.linkedin, 
  color: Color(0xFF0A66C2), // LinkedIn Official Blue
)
            ],
          )
        ],
      ),
    );
  }
}