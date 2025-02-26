import 'package:az_banking_app/src/modules/accounts/controllers/account_view_model.dart';
import 'package:az_banking_app/src/modules/accounts/views/account_tile.dart';
import 'package:az_banking_app/src/views/custom/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryAccountWidget extends StatelessWidget {
  const PrimaryAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountViewModel>(
      builder: (controller) => controller.primaryAccount != null
          ? ApiHandler(apiResponse: controller.accounts, onSuccess: AccountItemCard(accountModel: controller.primaryAccount!))
          : Container(),
    );
  }
}


