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
  static final RegExp _accountNumberRegExp = RegExp(r'^\d{11}$');

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

  static String? registerPhoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkPhoneRequiredMsg.tr;
    } else if (value.length != 9) {
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
      return TranslationsKeys.tkAccountNotValidMsg.tr;
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
    if (value == null || value.isEmpty || value.length != 11) {
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
  static String? generalValidator(
    dynamic value, [
    String message = TranslationsKeys.tkGeneralRequiredMsg,
  ]) {
    // Null check
    if (value == null) {
      return message.tr;
    }

    // String check (also trims)
    if (value is String && value.trim().isEmpty) {
      return message.tr;
    }

    // Otherwise valid
    return null;
  }

  /// Validates a bban.
  /// Returns a localized error message if the bban is null or empty, otherwise returns `null`.
  static String? validateBBAN(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkBBanRequiredMsg.tr;
    } else if (value.length != 14) {
      return TranslationsKeys.tkBBanNotValidMsg.tr;
    }
    return null;
  }

  /// Validates a RIM.
  /// Returns a localized error message if the RIM is null or empty, otherwise returns `null`.
  static String? validateE15Receipt(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkReceiptNumberRequiredMsg.tr;
    } else if (!(value.length >= 14 && value.length <= 24)) {
      return TranslationsKeys.tkReceiptNumberNotValidMsg.tr;
    }
    return null;
  }

  static String? validateAmount(String? value, [int minValue = 1]) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkAmountRequiredMsg.tr;
    } else if (double.parse(value) < minValue) {
      return TranslationsKeys.tkAmountNotValidMsg.tr;
    }
    return null;
  }

  static String? validateMoheField(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkMoheRequiredMsg.tr;
    } else if (value.length < 10) {
      return TranslationsKeys.tkMoheNotValidMsg.tr;
    }
    return null;
  }

  static String? validateMeterNumber(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkMeterNumberRequiredMsg.tr;
    } else if (value.length != 11 && value.length != 13) {
      return TranslationsKeys.tkMeterNumberNotValidMsg.tr;
    }
    return null;
  }

  static String? validateCustomsBankCode(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkCustomsBankCodeRequiredMsg.tr;
    } else if (!(value.length >= 8 && value.length <= 16)) {
      return TranslationsKeys.tkCustomsBankCodeNotValidMsg.tr;
    }
    return null;
  }

  static String? validateDeclarationCode(String? value) {
    if (value == null || value.isEmpty) {
      return TranslationsKeys.tkDeclarationCodeRequiredMsg.tr;
    } else if (!(value.length >= 8 && value.length <= 16)) {
      return TranslationsKeys.tkDeclarationCodeNotValidMsg.tr;
    }
    return null;
  }
}
