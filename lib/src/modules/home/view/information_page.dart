import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText.subtitle(
          Get.arguments['title'],
          color: ColorManager.titleColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: CustomText.subtitle(
          Get.arguments['content'],
          color: ColorManager.titleColor,
        ),
      ),
    );
  }
}
