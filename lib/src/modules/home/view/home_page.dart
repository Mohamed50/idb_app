import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/controllers/account_view_model.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_widget.dart';
import 'package:az_banking_app/src/modules/bank_services/controllers/bank_services_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/views/bank_services_grid.dart';
import 'package:az_banking_app/src/utils/screen_utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/side_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AccountViewModel>();
    Get.find<BankServicesViewModel>();
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: ScreenUtils.getScreenHeight(context),
          child: Column(
            children: [
              PrimaryAccountWidget(),
              Expanded(
                child: Container(
                  color: ColorManager.lightBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: CustomText.title(TranslationsKeys.tkServicesLabel),
                      ),
                      Expanded(child: BankServicesGrid()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
