import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';

class ServiceIconWidget extends StatelessWidget {
  final String iconPath;

  const ServiceIconWidget({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: ColorManager.primaryColor,
      padding: EdgeInsets.all(12.0),
      child: Image.asset(iconPath, width: 40, height: 40, color: Colors.white),
    );
  }
}

class ServiceIconWidget2 extends StatelessWidget {
  final String iconPath;

  const ServiceIconWidget2({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: ColorManager.primaryColor.withValues(alpha: 0.08),
      child: CustomCard(
        color: Colors.white,
        child: Image.asset(iconPath, width: 32, height: 32, color: ColorManager.primaryColor,),
      ),
    );
  }
}

class ServiceIconWidget3 extends StatelessWidget {
  final String iconPath;

  const ServiceIconWidget3({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: ColorManager.lightBackgroundColor.withValues(alpha: 0.3),
      child: Image.asset(iconPath, width: 32, height: 32, color: ColorManager.lightBackgroundColor,),
    );
  }
}
