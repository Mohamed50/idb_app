import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/actions/transfer_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/controllers/transfer_view_model.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'confirm_transfer_widget.dart';
import 'transfer_to_account_inside_bank_page.dart';

class TransferWithQrCodePage extends GetView<TransferViewModel> {
  static final _formKey = GlobalKey<FormState>();
  const TransferWithQrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onToAccountChanged(Get.arguments);
    return Scaffold(
      backgroundColor: ColorManager.lightBackgroundColor,
      appBar: CustomAppbar(title: TranslationsKeys.tkTransferInsideBankLabel),
      body: GetBuilder<TransferViewModel>(
        builder:(controller) => CustomVisible(
          show: !controller.isInfoAvailable(),
          placeHolder: ConfirmTransferWidget(formKey: _formKey,),
          child: InsideBankForm(formKey: _formKey),
        ),
      ),
    );
  }
}


