import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/actions/account_actions.dart';
import 'package:az_banking_app/src/modules/accounts/controllers/account_view_model.dart';
import 'package:az_banking_app/src/modules/accounts/controllers/link_account_view_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/auth/controllers/change_password_view_model.dart';
import 'package:az_banking_app/src/modules/auth/controllers/change_security_questions_view_model.dart';
import 'package:az_banking_app/src/modules/auth/controllers/forgot_password_view_model.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import '/src/essentials/config/action_presenter.dart';
import '../controllers/auth_view_model.dart';

class AuthActions extends ActionPresenter {
  static final AuthActions _mInstance = AuthActions._();

  static AuthActions get instance => _mInstance;

  AuthActions._();

  bool get isAuthenticated => Get.find<AuthViewModel>().isAuthenticated();

  Future signIn(BuildContext context) async {
    await actionHandler(context, () async {
      final controller = Get.find<AuthViewModel>();
      await controller.signIn();
      if (controller.user!.isResetDeviceRequired) {
        await controller.requestOtp();
        toResetDevicePage();
      }
    });
  }

  Future resetDevice(BuildContext context) async {
    actionHandler(context, () async {
      await Get.find<AuthViewModel>().resetDevice();
      back();
      showSuccessSnackBar('', TranslationsKeys.tkResetDeviceSuccessMsg);
    });
  }

  Future signUp(BuildContext context) async {
    actionHandler(context, () async {
      await Get.find<AuthViewModel>().signUp();
      Get.back();
      showSuccessSnackBar('', TranslationsKeys.tkRegisterSuccessMsg);
      toVerifyAccountPage();
    });
  }

  Future verifyAccount(BuildContext context) async {
    actionHandler(context, () async {
      final controller = Get.find<AuthViewModel>();

      /// get available accounts from verify
      final List<AccountModel> availableAccounts = await controller.verifyAccountByOtp();

      /// send the first one in the regCustSelfRegistration
      String userId = await controller.registerUser(availableAccounts.first);

      /// receive userId to link accounts
      hideLoader();
      await AccountActions.instance.toLinkAccountsPage(userId, availableAccounts);
      Get.offNamed(RouteManager.setPasswordRoute);
    });
  }

  void linkAccounts(BuildContext context) {
    actionHandler(context, () async {
      await Get.find<LinkAccountViewModel>().linkAccounts();
      if (Get.isRegistered<AccountViewModel>()) {
        Get.find<AccountViewModel>().refreshData();
      }
      Get.back();
      showSuccessSnackBar('', TranslationsKeys.tkLinkAccountsSuccessMsg);
    });
  }

  void setPassword(BuildContext context) {
    actionHandler(context, () async {
      final controller = Get.find<AuthViewModel>();
      await controller.setPassword();
      Get.back();
      showSuccessSnackBar('', TranslationsKeys.tkPasswordSetSuccessMsg);
    });
  }

  void signOut(BuildContext context) {
    actionHandler(context, () async {
      final controller = Get.find<AuthViewModel>();
      controller.logout();
      Phoenix.rebirth(context);
      Get.offNamedUntil(RouteManager.initialRoute, (route) => false);
    });
  }

  Future submitSecurityQuestionsAnswers(BuildContext context) async {
    actionHandler(context, () async {
      await Get.find<ForgotPasswordViewModel>().submitSecurityQuestionsAnswers();
      toResetPasswordPage();
    });
  }

  void resetPassword(BuildContext context) {
    actionHandler(context, () async {
      try {
        await Get.find<ForgotPasswordViewModel>().resetPassword();
        Get.until((route) => route.settings.name == RouteManager.authRoute);
        showSuccessSnackBar('', TranslationsKeys.tkResetPasswordSuccessMsg);
      } catch (e) {
        Get.find<AuthViewModel>().logout();
        rethrow;
      }
    });
  }

  void changePassword(BuildContext context) {
    actionHandler(context, () async {
      await Get.find<ChangePasswordViewModel>().changePassword();
      back();
      showSuccessSnackBar('', TranslationsKeys.tkChangePasswordSuccessMsg);
    });
  }

  Future changeSecurityQuestionsAnswers(BuildContext context) async {
    actionHandler(context, () async {
      await Get.find<ChangeSecurityQuestionViewModel>().changeSecurityQuestionsAnswers();
      back();
      showSuccessSnackBar('', TranslationsKeys.tkChangeSecurityQuestionsSuccessMsg);
    });
  }

  void toRegisterPage() {
    RouteManager.toRegisterPage();
  }

  void toPasswordResetPage() {
    Get.toNamed(RouteManager.forgotPasswordRoute);
  }

  void toResetDevicePage() {
    Get.toNamed(RouteManager.resetDeviceRoute);
  }

  Future toSecurityQuestionsPage() async {
    Get.toNamed(RouteManager.securityQuestionsRoute, arguments: Get.find<AuthViewModel>().username);
  }

  Future toResetPasswordPage() async {
    Get.toNamed(RouteManager.resetPasswordRoute);
  }

  Future toVerifyAccountPage() async {
    Get.toNamed(RouteManager.verifyAccountRoute, arguments: Get.find<AuthViewModel>().username);
  }

  void toCustomService() {}
}
