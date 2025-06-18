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
enum AccountType { current, saving, staff, ntd }

extension AccountTypeExtensions on AccountType {
  /// **Returns the display label for the enum.**
  String toLabel() {
    switch (this) {
      case AccountType.current:
        return 'Current Account';
      case AccountType.saving:
        return 'Saving Account';
      case AccountType.staff:
        return 'Staff Account';
      case AccountType.ntd:
        return 'NTD Account';
    }
  }

  /// **Returns the string value of the enum.**
  String toCode() {
    switch (this) {
      case AccountType.current:
        return '101';
      case AccountType.saving:
        return '202';
      case AccountType.staff:
        return '105';
      case AccountType.ntd:
        return '000';
    }
  }

  /// **Converts a string value to an `AccountType` enum.**
  static AccountType? fromCode(String value) {
    switch (value) {
      case 'CUR':
      case '101':
        return AccountType.current;
      case 'SAV':
      case '202':
        return AccountType.saving;
      case 'staff':
      case '105':
        return AccountType.staff;
      default:
        return AccountType.ntd;
    }
  }
}
