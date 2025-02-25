import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/auth/auth.dart';
import 'package:az_banking_app/src/modules/auth/data/models/user.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerNameWidget extends StatelessWidget {
  const CustomerNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      builder: (controller) {
        UserModel userModel = controller.user!;
        return Row(
          children: [
            CustomText.subtitle(TranslationsKeys.tkWelcomeLabel),
            SizedBox(width: 12.0),
            CustomText.title(userModel.customerName),
          ],
        );
      },
    );
  }
}
