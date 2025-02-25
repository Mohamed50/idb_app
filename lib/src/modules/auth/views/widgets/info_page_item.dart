import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/views/custom/custom_container.dart';
import 'package:flutter/material.dart';

class InfoPageItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback onTap;

  const InfoPageItem({super.key, required this.iconData, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomCard(
        padding: EdgeInsets.all(12.0),
        color: ColorManager.primaryColor.withValues(alpha: 0.08),
        shape: BoxShape.circle,
        child: Icon(iconData, color: ColorManager.primaryColor),
      ),
    );
  }
}
