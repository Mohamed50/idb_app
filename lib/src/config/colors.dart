import 'package:flutter/material.dart';

/// A centralized manager for defining colors and gradients used across the app.
class ColorManager {
  ColorManager._();

  /// **Primary Swatch**: Custom MaterialColor for Deep Maroon (`#7A1D17`).
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF7A1D17, // Primary Color (Deep Maroon)
    <int, Color>{
      50: Color(0xFFF2E0DF),  // Lightest Shade
      100: Color(0xFFD9B3B0),
      200: Color(0xFFBF807E),
      300: Color(0xFFA64D4D),
      400: Color(0xFF902929),
      500: Color(0xFF7A1D17),  // Base Color
      600: Color(0xFF6E1A14),
      700: Color(0xFF5E1611),
      800: Color(0xFF4D130E),
      900: Color(0xFF3A0E0A),  // Darkest Shade
    },
  );
  // **Basic Colors**
  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color darkBackgroundColor = Color(0xFFF5F5F5);
  static const Color primaryColor = Color(0xFF7A1D17);
  static const Color secondaryColor = Color(0xFF4D8334);
  static const Color transparentNavy = Color(0xFFECEFF8);
  static const Color darkerTransparentNavy = Color(0xFFC6D4FC);
  static const Color appBarColor = Colors.white;
  static const Color iconsColor = Colors.white;
  static const Color onButtonColor = Colors.white;
  static const Color titleColor = Colors.black;
  static const Color bodyColor = Colors.grey;
  static const Color buttonColor = Color(0xFF7A1D17);
  static const Color lightButtonColor = Color(0xFFA64D4D);
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

}
