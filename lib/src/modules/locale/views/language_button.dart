import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/utils/utils.dart';
import '/src/config/config.dart';
import '/src/views/custom/customs.dart';
import '../controllers/localization_view_model.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationViewModel>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: supportedLanguage
            .map(
              (e) => InkWell(
                onTap: () => _confirm(e),
                child: CustomText.title(
                  e.name,
                  fontSize: 16.0,
                  color: controller.language == e ? ColorManager.primaryColor : null,
                  fontWeight: controller.language == e ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            )
            .toList(), // Handle the language change.
      ),
    );
  }

  void _confirm(LanguageModel languageModel) {
    Get.find<LocalizationViewModel>().onChange(languageModel);
    Get.find<LocalizationViewModel>().saveLanguageChange();
    Get.back(); // Close the dialog.
  }
}
