import 'package:az_banking_app/src/config/colors.dart';
import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/transactions_limit/controllers/transactions_limit_view_model.dart';
import 'package:az_banking_app/src/modules/transactions_limit/data/models/transaction_limit_model.dart';
import 'package:az_banking_app/src/modules/transactions_limit/views/widgets/fees_table.dart';
import 'package:az_banking_app/src/views/custom/api_handler.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:az_banking_app/src/views/custom/custom_container.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/limits_table.dart';

class TransactionsLimitPage extends GetView<TransactionsLimitViewModel> {
  const TransactionsLimitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightBackgroundColor,
      appBar: CustomAppbar(title: TranslationsKeys.tkTransactionLimitLabel,),
      body: Obx(
        () => ApiHandler(
          apiResponse: controller.transactionsLimits,
          onSuccess: _OnSuccess(transactionsLimit: controller.transactionsLimits.data),
        ),
      ),
    );
  }
}

class _OnSuccess extends StatelessWidget {
  final TransactionsLimitModel? transactionsLimit;

  const _OnSuccess({required this.transactionsLimit});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(24.0),
      children: [
        CustomCard(
          color: ColorManager.darkBackgroundColor,
          borderRadius: BorderRadius.zero,
          padding: EdgeInsets.zero,
          child: LimitsTable(limits: transactionsLimit!.limitsList),
        ),
        SizedBox(height: 24.0),
        CustomCard(
          color: ColorManager.darkBackgroundColor,
          borderRadius: BorderRadius.zero,
          padding: EdgeInsets.zero,
          child: FeesTable(fees: transactionsLimit!.feesList),
        ),
      ],
    );
  }
}
