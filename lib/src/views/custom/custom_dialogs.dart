import 'package:az_banking_app/src/config/config.dart';
import 'package:flutter/material.dart';

import 'customs.dart';

class ConfirmationDialog extends StatelessWidget {
  final String message;
  const ConfirmationDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return
      Dialog(
        backgroundColor: ColorManager.darkBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText.title(message), // Display confirmation message.
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Expanded(
                    child: CustomButton.positive(
                      text: TranslationsKeys.tkYesLabel,
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  Expanded(
                    child: CustomButton.negative(
                      text: TranslationsKeys.tkNoLabel,
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
