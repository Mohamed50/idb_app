import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/controllers/account_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/actions/bank_service_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/controllers/bank_services_view_model.dart';
import 'package:az_banking_app/src/modules/exchange_rate/controllers/exchange_rate_view_model.dart';
import 'package:az_banking_app/src/modules/exchange_rate/views/exchange_rates_page.dart';
import 'package:az_banking_app/src/modules/home/home.dart';
import 'package:az_banking_app/src/modules/home/view/settings_page.dart';
import 'package:az_banking_app/src/modules/statements/controllers/statement_view_model.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../bank_services/views/services_page.dart';
import '/src/modules/menu/menu.dart';

class MenuPage extends GetView<MenuViewModel> {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AccountViewModel>();
    Get.find<BankServicesViewModel>();
    Get.find<StatementViewModel>();
    Get.find<ExchangeRateViewModel>();
    return Scaffold(
      backgroundColor: ColorManager.lightBackgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primaryColor,
        shape: CircleBorder(),
        onPressed: BankServicesActions.instance.handleTransferWithQrCode,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(AssetsManager.icQRPath, color: Colors.white),
        ),
      ),
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar(
          icons: [
            FontAwesomeIcons.house,
            FontAwesomeIcons.shapes,
            FontAwesomeIcons.dollarSign,
            FontAwesomeIcons.user,
          ],
          blurEffect: false,
          activeIndex: controller.selectedIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          rightCornerRadius: 12.0,
          leftCornerRadius: 12.0,
          gapWidth: 24,
          backgroundColor: ColorManager.lightBackgroundColor,
          activeColor: ColorManager.primaryColor,
          inactiveColor: ColorManager.secondaryColor.withValues(alpha: 0.3),
          onTap: controller.onIndexChanges,
          //other params
        ),
      ),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanges,
        children: [
          HomePage(),
          BankServicesPage(),
          ExchangeRatesPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
