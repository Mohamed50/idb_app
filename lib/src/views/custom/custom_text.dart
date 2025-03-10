import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/config/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final double? letterSpacing;
  final double? height;
  final int? maxLines;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  const CustomText(this.text,
      {super.key,
      this.color = ColorManager.titleColor,
      this.fontSize = 14,
      this.fontWeight,
      this.height,
      this.letterSpacing,
      this.fontFamily,
      this.textAlign,
      this.maxLines,
      this.decoration});

  const CustomText.title(this.text,
      {super.key,
      this.color = ColorManager.titleColor,
      this.fontSize = 20.0,
      this.fontWeight = FontWeight.w700,
      this.height,
      this.letterSpacing,
      this.fontFamily,
      this.textAlign,
      this.maxLines,
      this.decoration});

  const CustomText.subtitle(this.text,
      {super.key,
      this.color = ColorManager.bodyColor,
      this.fontSize = 14.0,
      this.fontWeight,
      this.height,
      this.letterSpacing,
      this.fontFamily,
      this.textAlign,
      this.maxLines,
      this.decoration});

  const CustomText.error(this.text,
      {super.key,
      this.color = ColorManager.negativeColor,
      this.fontSize = 12.0,
      this.fontWeight,
      this.height,
      this.letterSpacing,
      this.fontFamily,
      this.textAlign,
      this.maxLines,
      this.decoration});

  const CustomText.underline(
    this.text, {
    super.key,
    this.color = ColorManager.primaryColor,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w400,
    this.height,
    this.letterSpacing,
    this.fontFamily,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.decoration = TextDecoration.underline,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
        fontFamily: fontFamily,
        decoration: decoration,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

class CustomTranslatedText extends StatelessWidget {
  final String textEn;
  final String textAr;
  final Color? color;
  final double? fontSize;
  final double? letterSpacing;
  final double? height;
  final int? maxLines;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;

  const CustomTranslatedText(
      {required this.textEn,
      required this.textAr,
      super.key,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.height,
      this.letterSpacing,
      this.fontFamily,
      this.textAlign,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      Get.locale!.languageCode == 'en' ? textEn : textAr,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
        fontFamily: fontFamily,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
