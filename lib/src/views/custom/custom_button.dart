import 'package:flutter/material.dart';
import '/src/utils/screen_utils.dart';
import '../../config/config.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final double? width;
  final LinearGradient gradient;
  final Color textColor;
  final double fontSize;
  final bool enabled;
  final EdgeInsets? padding;

  const CustomButton({
    super.key,
    this.text,
    this.onPressed,
    this.width = double.infinity,
    this.gradient = ColorManager.buttonGradient,
    this.textColor = ColorManager.onButtonColor,
    this.fontSize = 16.0,
    this.enabled = true,
    this.padding,
    this.child,
  });

  const CustomButton.positive({
    super.key,
    this.text,
    this.onPressed,
    this.width = double.infinity,
    this.gradient = ColorManager.positiveButtonGradient,
    this.textColor = ColorManager.onButtonColor,
    this.fontSize = 16.0,
    this.enabled = true,
    this.padding,
    this.child,
  });

  const CustomButton.negative({
    super.key,
    this.text,
    this.onPressed,
    this.width = double.infinity,
    this.gradient = ColorManager.negativeButtonGradient,
    this.textColor = ColorManager.onButtonColor,
    this.fontSize = 16.0,
    this.enabled = true,
    this.padding,
    this.child,
  });

  const CustomButton.muted({
    super.key,
    this.text,
    this.onPressed,
    this.width = double.infinity,
    this.gradient = ColorManager.mutedButtonGradient,
    this.textColor = ColorManager.onButtonColor,
    this.fontSize = 16.0,
    this.enabled = true,
    this.padding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onPressed : null,
      child: Container(
          width: width ?? ScreenUtils.getScreenWidth(context, 0.12),
          padding: padding ?? EdgeInsets.all(ScreenUtils.getFontSize(context, 16)),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: child ??
              CustomText(
                text ?? '',
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              )),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final double? width;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final bool enabled;
  final EdgeInsets? padding;

  const CustomOutlinedButton({
    super.key,
    this.text,
    this.onPressed,
    this.width = double.infinity,
    this.backgroundColor = ColorManager.primaryColor,
    this.textColor = ColorManager.primaryColor,
    this.fontSize = 16.0,
    this.enabled = true,
    this.padding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onPressed : null,
      child: Container(
        width: width ?? ScreenUtils.getScreenWidth(context, 0.12),
        padding: padding ?? EdgeInsets.all(ScreenUtils.getFontSize(context, 16)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: backgroundColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: child ??
            CustomText(
              text ?? '',
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
      ),
    );
  }
}
