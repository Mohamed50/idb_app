import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_list.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManager.lightBackgroundColor,
      appBar: CustomAppbar(title: TranslationsKeys.tkLinkedAccounts),
      body: AccountsList(),
    );
  }
}
