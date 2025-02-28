import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_list.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/actions/transfer_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/controllers/transfer_view_model.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmTransferWidget extends GetView<TransferViewModel> {
  const ConfirmTransferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(24.0),
      children: [
        CustomText.title(
          TranslationsKeys.tkFromAccountLabel,
          fontSize: 14.0,
        ),
        SizedBox(height: 8.0),
        AccountItemTile(accountModel: controller.fromAccount!),
        SizedBox(height: 24.0),
        CustomText.title(
          TranslationsKeys.tkToAccountLabel,
          fontSize: 14.0,
        ),
        SizedBox(height: 8.0),
        AccountItemTile(
          accountModel: controller.toAccount!,
          withName: true,
        ),
        SizedBox(height: 24.0),
        CustomText.title(
          TranslationsKeys.tkTransactionInfoLabel,
          fontSize: 14.0,
        ),
        SizedBox(height: 8.0),
        CustomCard(
          color: ColorManager.darkBackgroundColor,
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.subtitle(
                    TranslationsKeys.tkPhoneLabel,
                    fontSize: 10.0,
                  ),
                  CustomText.title(
                    controller.phone ?? '',
                    fontSize: 12.0,
                  ),
                  SizedBox(height: 12.0),
                  CustomText.subtitle(
                    TranslationsKeys.tkCommentsLabel,
                    fontSize: 10.0,
                  ),
                  CustomText.title(
                    controller.comment ?? '',
                    fontSize: 12.0,
                  ),
                ],
              ),
              Spacer(),
              CustomText.title(
                controller.amount.toString(),
                fontSize: 24,
                color: ColorManager.primaryColor,
              ),
              SizedBox(width: 4.0),
              CustomText.subtitle(TranslationsKeys.tkSDGLabel),
            ],
          ),
        ),
        SizedBox(height: 32.0),
        CustomButton(
          text: TranslationsKeys.tkConfirmBtn,
          onPressed: () => _confirm(context),
        )
      ],
    );
  }

  void _confirm(BuildContext context) {
    if (controller.toAccountBBan == null) {
      TransferActions.instance.transferInsideBank(context);
    } else {
      TransferActions.instance.transferOutsideBank(context);
    }
  }
}
