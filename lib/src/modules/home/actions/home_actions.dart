import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeActions {
  static final HomeActions _mInstance = HomeActions._();

  static HomeActions get instance => _mInstance;

  HomeActions._();

  Future<void> toHomePage(BuildContext context) async {
    back();
  }

  /// Navigates back to the previous page.
  void back() {
    Get.back();
  }
  void toContactUsPage() {
    Get.toNamed(RouteManager.informationContactUsRoute);
  }

  void toBranchesPage() {
    Get.toNamed(RouteManager.branchesRoute);
  }

  void toAboutUsPage() {
    Get.toNamed(RouteManager.informationAboutUsRoute);
  }

  void toTermsAndConditionsPage() {
    Get.toNamed(RouteManager.informationTermsAndConditionsRoute);
  }

  void toWebsitePage() {
    launchUrlString('https://www.idb.sd');
  }

  void toSettingsPage() {
    Get.toNamed(RouteManager.settingsRoute);
  }

  void toStatementPage() {
    Get.toNamed(RouteManager.statementRoute);
  }
}
