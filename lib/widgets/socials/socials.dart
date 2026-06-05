import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class socialInfo extends StatelessWidget {
  const socialInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Get in Touch.'),
          Row(
            children: [
              FlutterSocialButton(
                onTap: () => (),
                buttonType: ButtonType.instagram,
              )
            ],
          )
        ],
      ),
    );
  }
}