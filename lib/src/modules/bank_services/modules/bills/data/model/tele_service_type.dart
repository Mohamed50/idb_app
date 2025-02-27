import 'package:az_banking_app/src/config/config.dart';
import 'package:get/get.dart';

/// **TeleServiceType Enum**
///
/// Represents different types of telecom services with a `toLabel()` method.
///
/// **Methods:**
/// - `toLabel()` → Returns a user-friendly label for each enum value.
///
// ─────────────────────────────────────────────────────
enum TeleServiceType { topUp, inquiry, payment }

extension TeleServiceTypeExtensions on TeleServiceType {

  /// **Returns a user-friendly label for each service type.**
  String toLabel() {
    switch (this) {
      case TeleServiceType.topUp:
        return TranslationsKeys.tkTopUpLabel.tr;
      case TeleServiceType.inquiry:
        return TranslationsKeys.tkBillInquiryLabel.tr;
      case TeleServiceType.payment:
        return TranslationsKeys.tkBillPaymentLabel.tr;
    }
  }
}
