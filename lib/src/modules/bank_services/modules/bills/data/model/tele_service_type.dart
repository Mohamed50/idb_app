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
        return 'Top-Up';
      case TeleServiceType.inquiry:
        return 'Balance Inquiry';
      case TeleServiceType.payment:
        return 'Bill Payment';
    }
  }
}
