import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_list.dart';
import 'package:az_banking_app/src/modules/accounts/views/number_of_accounts_widget.dart';
import 'package:az_banking_app/src/modules/auth/auth.dart';
import 'package:az_banking_app/src/modules/auth/views/widgets/user_info_widget.dart';
import 'package:az_banking_app/src/modules/home/home.dart';
import 'package:az_banking_app/src/modules/home/view/widgets/settings_service_grid.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:az_banking_app/src/views/custom/custom_button.dart';
import 'package:az_banking_app/src/views/custom/custom_container.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightBackgroundColor,
      appBar: CustomAppbar(
        title: TranslationsKeys.tkSettingsLabel,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          UserInfoWidget(),
          SizedBox(height: 12.0),
          AccountsList(),
          Divider(height: 60.0, thickness: 4, color: ColorManager.primaryColor.withValues(alpha: 0.08),),
          SettingsServiceGrid(),
        ],
      ),
    );
  }
}

