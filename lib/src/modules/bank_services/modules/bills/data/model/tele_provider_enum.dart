import 'dart:ui';

import 'package:az_banking_app/src/config/assets.dart';
/// **TeleProvider Enum**
///
/// Represents Sudanese telecommunication providers with label and icon methods.
///
/// **Methods:**
/// - `toLabel()` → Returns a human-readable label.
/// - `toIcon()` → Returns the associated icon widget.
///
// ─────────────────────────────────────────────────────
enum TeleProvider { zain, mtn, sudani }

extension TeleProviderExtensions on TeleProvider {

  /// **Returns a user-friendly label for each provider.**
  String toLabel() {
    switch (this) {
      case TeleProvider.zain:
        return 'Zain Sudan';
      case TeleProvider.mtn:
        return 'MTN Sudan';
      case TeleProvider.sudani:
        return 'Sudani Telecom';
    }
  }

  /// **Returns an icon representing the provider.**
  String toIconPath({double size = 40.0}) {
    switch (this) {
      case TeleProvider.zain:
        return AssetsManager.icBillZainPath;
      case TeleProvider.mtn:
        return AssetsManager.icBillMtnPath;
      case TeleProvider.sudani:
        return AssetsManager.icBillSudaniPath;
    }
  }

  /// **Returns an icon representing the provider.**
  Color toColor({double size = 40.0}) {
    switch (this) {
      case TeleProvider.zain:
        return Color(0xFF1C1C1C);
      case TeleProvider.mtn:
        return Color(0xFFFFCD00);
      case TeleProvider.sudani:
        return Color(0xFF007BFF);
    }
  }
}
