import 'package:az_banking_app/src/config/app_exception.dart';
import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/auth/data/models/question_model.dart';
import 'package:az_banking_app/src/modules/auth/data/services/password_service.dart';
import 'package:get/get.dart';

/// ViewModel responsible for managing authentication logic using GetX.
class ChangePasswordViewModel extends GetxController {
  /// Instance of `AuthService` to perform authentication-related operations.
  final PasswordService _passwordService;

  String? _currentPassword, _newPassword, _confirmNewPassword;

  ChangePasswordViewModel(this._passwordService);


  Future changePassword() async {
    if(_newPassword == _confirmNewPassword) {
      await _passwordService.changePassword(_currentPassword!, _newPassword!);
    }
    else{
      throw AppException(TranslationsKeys.tkChangePasswordValidationErrorMsg);
    }
  }


  void onCurrentPasswordChanged(String? newValue) {
    _currentPassword = newValue;
  }


  void onNewPasswordChanged(String? newValue) {
    _newPassword = newValue;
  }


  void onConfirmNewPasswordChanged(String? newValue) {
    _confirmNewPassword = newValue;
  }
}
