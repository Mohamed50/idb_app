import 'package:az_banking_app/src/modules/auth/controllers/change_password_view_model.dart';
import 'package:az_banking_app/src/modules/auth/controllers/change_security_questions_view_model.dart';
import 'package:az_banking_app/src/modules/auth/controllers/forgot_password_view_model.dart';
import 'package:az_banking_app/src/modules/auth/data/services/password_service.dart';
import 'package:get/get.dart';
import 'auth.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => AuthViewModel(Get.find()));
  }
}

class ForgotPasswordBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasswordService());
    Get.lazyPut(() => ForgotPasswordViewModel(Get.find(), Get.arguments));
  }
}

class ChangePasswordBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasswordService());
    Get.lazyPut(() => ChangePasswordViewModel(Get.find()));
  }
}

class ChangeSecurityQuestionBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasswordService());
    Get.lazyPut(() => ChangeSecurityQuestionViewModel(Get.find()));
  }
}