import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: Get.arguments['title'],
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
