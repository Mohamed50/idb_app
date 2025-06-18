import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '/src/modules/auth/auth.dart';

class HomeActions {
  static final HomeActions _mInstance = HomeActions._();

  static HomeActions get instance => _mInstance;

  HomeActions._();

  Future<void> toHomePage(BuildContext context) async {
    back();
  }

  /// Logs out the user by calling the logout method from [AuthViewModel].
  Future<void> logout(BuildContext context) async {
    Get.find<AuthViewModel>().logout(); // Log out the user.
    Get.back(); // Navigate back to the previous screen.
  }

  /// Navigates back to the previous page.
  void back() {
    Get.back();
  }

  void toWebsitePage() {
    launchUrlString('www.idb.sd');
  }

  void toContactUsPage() {
    launchUrlString('tel://+249187181300');
  }

  void toBranchesPage() {
    Get.toNamed(RouteManager.branchesRoute);
  }

  void toAboutUsPage() {
    Get.toNamed(
      RouteManager.informationRoute,
      arguments: {'title': TranslationsKeys.tkAboutUsLabel, 'content': TranslationsKeys.tkAboutUsContent},
    );
  }

  void toTermsAndConditionsPage() {
    Get.toNamed(
      RouteManager.informationRoute,
      arguments: {'title': TranslationsKeys.tkTermsAndConditions, 'content': TranslationsKeys.tkTermsContent},
    );
  }

  void toSettingsPage() {
    Get.toNamed(RouteManager.settingsRoute);
  }

  void toStatementPage() {
    Get.toNamed(RouteManager.statementRoute);
  }
}
