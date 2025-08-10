import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/src/config/config.dart';

/// A class to handle input validations such as phone numbers, emails, passwords, and usernames.
class InputsValidator {
  /// Regular expression to validate phone numbers.
  /// Works with the following formats:
  /// - 01xxxxxxxx
  /// - 01x-xxx-xxxx
  /// - 01x xxx xxxx
  /// - 09xxxxxxxx
  /// - 09x-xxx-xxxx
  /// - 09x xxx xxxx
  /// - 1xxxxxxxx
  /// - 9xxxxxxxx
  static final RegExp _phoneRegExp = RegExp(r'^(?:01|09)\d{8}$');
  static final RegExp _sudaniRegExp = RegExp(r'^01\d{8}$');
  static final RegExp _zainRegExp = RegExp(r'^09\d{8}$');
  static final RegExp _mtnRegExp = RegExp(r'^(099|092)\d{7}$');
  static final RegExp _meterNumberRegExp = RegExp(r'^(099|092)\d{7}$');
  static final RegExp _accountNumberRegExp = RegExp(r'^\d{11}$');

  /// Regular expression to validate email addresses.
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$",
  );

  /// Regular expression to validate passwords.
  /// Ensures the password contains:
  /// - At least one uppercase letter
  /// - At least one lowercase letter
  /// - At least one numeric digit
  /// - At least one special character
  /// - Minimum length of 8 characters
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );

  /// Validates a phone number.
  /// Returns a localized error message if the phone number is invalid or null, otherwise returns `null`.
  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkPhoneRequiredMsg.tr;
    } else if (!_phoneRegExp.hasMatch(value)) {
      return TranslationsKeys.tkPhoneNotValidMsg.tr;
    }
    return null;
  }

  /// Validates a phone number.
  /// Returns a localized error message if the phone number is invalid or null, otherwise returns `null`.
  static String? sudaniValidator(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkPhoneRequiredMsg.tr;
    } else if (!_sudaniRegExp.hasMatch(value)) {
      return TranslationsKeys.tkPhoneNotValidMsg.tr;
    }
    return null;
  }

  /// Validates a phone number.
  /// Returns a localized error message if the phone number is invalid or null, otherwise returns `null`.
  static String? zainValidator(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkPhoneRequiredMsg.tr;
    } else if (!_zainRegExp.hasMatch(value)) {
      return TranslationsKeys.tkPhoneNotValidMsg.tr;
    }
    return null;
  }

  /// Validates account number.
  /// Returns a localized error message if the phone number is invalid or null, otherwise returns `null`.
  static String? accountNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkGeneralRequiredMsg.tr;
    } else if (!_accountNumberRegExp.hasMatch(value)) {
      return TranslationsKeys.tkGeneralRequiredMsg.tr;
    }
    return null;
  }

  /// Validates a phone number.
  /// Returns a localized error message if the phone number is invalid or null, otherwise returns `null`.
  static String? mtnValidator(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkPhoneRequiredMsg.tr;
    } else if (!_mtnRegExp.hasMatch(value)) {
      return TranslationsKeys.tkPhoneNotValidMsg.tr;
    }
    return null;
  }

  /// Validates a password.
  /// Returns a localized error message if the password is invalid or null, otherwise returns `null`.
  static String? passwordRequiredOnlyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkPasswordRequiredMsg.tr;
    }
    return null;
  }

  /// Validates a username.
  /// Returns a localized error message if the username is null or empty, otherwise returns `null`.
  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty && value.length <= 10) {
      return TranslationsKeys.tkUsernameRequiredMsg.tr;
    }
    return null;
  }

  /// Validates a otp.
  /// Returns a localized error message if the username is null or empty, otherwise returns `null`.
  static String? otpValidator(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkOtpRequiredMsg.tr;
    }
    return null;
  }

  /// Validates a national Number.
  /// Returns a localized error message if the national Number is null or empty, otherwise returns `null`.
  static String? nationalNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkNationalNumberRequiredMsg.tr;
    }
    return null;
  }

  /// Validates a RIM.
  /// Returns a localized error message if the RIM is null or empty, otherwise returns `null`.
  static String? rimValidator(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkRimRequiredMsg.tr;
    }
    return null;
  }

  /// Validates a RIM.
  /// Returns a localized error message if the RIM is null or empty, otherwise returns `null`.
  static String? answerValidator(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkAnswerRequiredLabel.tr;
    }
    return null;
  }

  /// Validates a RIM.
  /// Returns a localized error message if the RIM is null or empty, otherwise returns `null`.
  static String? generalValidator(dynamic value, [String message = TranslationsKeys.tkGeneralRequiredMsg]) {
    if (value == null || (value is String && value.isEmpty)) {
      return message.tr;
    }
    return null;
  }

  /// Validates a RIM.
  /// Returns a localized error message if the RIM is null or empty, otherwise returns `null`.
  static String? validateBBAN(dynamic value) {
    if (value == null || value.isEmpty || value.length != 14) {
      return TranslationsKeys.tkGeneralRequiredMsg.tr;
    }
    return null;
  }
}
