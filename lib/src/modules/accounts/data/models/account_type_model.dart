/// **AccountType Enum**
///
/// Represents different types of accounts with label, value, and fromValue methods.
///
/// **Methods:**
/// - `toLabel()` → Returns a human-readable label.
/// - `toValue()` → Returns a string representation of the enum value.
/// - `fromValue()` → Returns the corresponding enum from a string.
///
// ─────────────────────────────────────────────────────
enum AccountType { current, saving, ntd }

extension AccountTypeExtensions on AccountType {
  /// **Returns the display label for the enum.**
  String toLabel() {
    switch (this) {
      case AccountType.current:
        return 'Current Account';
      case AccountType.saving:
        return 'Saving Account';
      case AccountType.ntd:
        return 'NTD Account';
    }
  }

  /// **Returns the string value of the enum.**
  String toCode() {
    switch (this) {
      case AccountType.current:
        return 'CUR';
      case AccountType.saving:
        return 'SAV';
      case AccountType.ntd:
        return 'NTD';
    }
  }

  /// **Converts a string value to an `AccountType` enum.**
  static AccountType? fromCode(String value) {
    switch (value) {
      case 'CUR':
        return AccountType.current;
      case 'SAV':
        return AccountType.saving;
      case 'NTD':
        return AccountType.ntd;
      default:
        return null;
    }
  }
}
