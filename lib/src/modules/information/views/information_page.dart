import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/information/controllers/information_view_model.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

enum InformationType { aboutUs, termsAndConditions, contactUs }

class InformationPage extends GetView<InformationViewModel> {
  final InformationType type;

  const InformationPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final String title;
    final String content;

    switch (type) {
      case InformationType.aboutUs:
        title = TranslationsKeys.tkAboutUsLabel;
        content = controller.aboutUsContent ?? '';
        break;
      case InformationType.termsAndConditions:
        title = TranslationsKeys.tkTermsAndConditions;
        content = controller.termsAndConditionsContent ?? '';
        break;
      case InformationType.contactUs:
        title = TranslationsKeys.tkContactUsLabel;
        content = controller.contactUsContent ?? '';
        break;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        title: CustomText.title(
          title,
          color: ColorManager.appBarColor,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [Html(data: content)],
      ),
    );
  }
}
