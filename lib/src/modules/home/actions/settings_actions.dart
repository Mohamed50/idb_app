import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/essentials/config/action_presenter.dart';
import 'package:az_banking_app/src/modules/locale/controllers/localization_view_model.dart';
import 'package:az_banking_app/src/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '/src/modules/auth/auth.dart';

class SettingsActions extends ActionPresenter {
  static final SettingsActions _mInstance = SettingsActions._();

  static SettingsActions get instance => _mInstance;

  SettingsActions._();

  void toChangePasswordPage() {
    Get.toNamed(RouteManager.changePasswordRoute);
  }

  void toSecurityQuestionsPage() {
    Get.toNamed(RouteManager.changeSecurityQuestionsRoute);
  }

  void toFaqsPage() {
    Get.toNamed(RouteManager.faqsRoute);
  }

  void toTransactionLimitPage() {
    Get.toNamed(RouteManager.transactionLimitRoute);
  }

  void toLanguageSelectorPage() {
    Get.find<LocalizationViewModel>().switchLanguage();
  }
}
