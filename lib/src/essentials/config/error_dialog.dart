import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorDialog extends StatelessWidget {
  final String text;

  const ErrorDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      insetPadding: const EdgeInsets.all(24.0),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.red[100],
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: ColorManager.negativeColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: ColorManager.negativeColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.error_outline, color: ColorManager.negativeColor, size: 48.0),
              ),
            ),
            const SizedBox(height: 24.0),
            Flexible(
              child: CustomText.title(
                text,
                fontSize: 16.0,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 16.0),
            CustomButton(
              text: TranslationsKeys.tkCloseLabel,
              fontSize: 14.0,
              gradient: ColorManager.negativeButtonGradient,
              textColor: Colors.white,
              onPressed: () => _close(context),
            ),
          ],
        ),
      ),
    );
  }

  void _close(BuildContext context) {
    Get.back();
  }
}
