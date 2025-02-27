import 'package:flutter/material.dart';

/// A centralized manager for defining colors and gradients used across the app.
class ColorManager {
  ColorManager._();

  // **Primary Swatch**: A custom primary swatch for consistent theming.
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF00A79B,
    <int, Color>{
      50: Color(0xFFE0F7F5),
      100: Color(0xFFB3EBE3),
      200: Color(0xFF80DED1),
      300: Color(0xFF4DD0BE),
      400: Color(0xFF26C6AF),
      500: Color(0xFF00A79B),
      600: Color(0xFF009B8D),
      700: Color(0xFF008A7C),
      800: Color(0xFF00796B),
      900: Color(0xFF00594D),
    },
  );

  // **Basic Colors**
  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color darkBackgroundColor = Color(0xFFF5F5F5);
  static const Color primaryColor = Color(0xFF0F225E);
  static const Color secondaryColor = Color(0xFF2C468F);
  static const Color darkerColor = Color(0xFF1A337F);
  static const Color transparentNavy = Color(0xFFECEFF8);
  static const Color darkerTransparentNavy = Color(0xFFC6D4FC);
  static const Color appBarColor = Colors.white;
  static const Color iconsColor = Colors.white;
  static const Color onButtonColor = Colors.white;
  static const Color titleColor = Colors.black;
  static const Color bodyColor = Colors.grey;
  static const Color buttonColor = Color(0xFF1A337F);
  static const Color lightButtonColor = Color(0xFF36477E);
  static const Color negativeColor = Color(0xFFBE1500);
  static const Color darkNegativeColor = Color(0xFF641005);
  static const Color positiveColor = Color(0xFF0F8A32);
  static const Color darkPositiveColor = Color(0xFF055D1C);

  // **Gradients**
  static const LinearGradient mutedButtonGradient = LinearGradient(
    colors: [darkerTransparentNavy, buttonColor],
  );
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [buttonColor, lightButtonColor],
  );
  static const LinearGradient secondaryButtonGradient = LinearGradient(
    colors: [buttonColor, lightButtonColor],
  );
  static const LinearGradient positiveButtonGradient = LinearGradient(
    colors: [darkPositiveColor, positiveColor],
  );
  static const LinearGradient negativeButtonGradient = LinearGradient(
    colors: [darkNegativeColor, negativeColor],
  );

  static const LinearGradient bottomNavigationGradient = LinearGradient(
    colors: [primaryColor, darkerColor],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
}
