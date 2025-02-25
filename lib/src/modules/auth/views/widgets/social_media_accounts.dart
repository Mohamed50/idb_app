import 'package:az_banking_app/src/config/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaAccounts extends StatelessWidget {
  const SocialMediaAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SocialMediaIcon(iconData: FontAwesomeIcons.linkedin, label: 'About Us'),
          SizedBox(width: 24.0),
          SocialMediaIcon(iconData: FontAwesomeIcons.youtube, label: 'Branches'),
          SizedBox(width: 24.0),
          SocialMediaIcon(iconData: FontAwesomeIcons.x, label: 'Contact'),
          SizedBox(width: 24.0),
          SocialMediaIcon(iconData: FontAwesomeIcons.facebook, label: 'About Us'),
        ],
      );

  }
}

class SocialMediaIcon extends StatelessWidget {
  final IconData iconData;
  final String label;

  const SocialMediaIcon({super.key, required this.iconData, required this.label});

  @override
  Widget build(BuildContext context) {
    return FaIcon(iconData, color: ColorManager.primaryColor);
  }
}
