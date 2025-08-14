import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_list.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/actions/transfer_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/controllers/transfer_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/views/amount_input_field.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmTransferWidget extends GetView<TransferViewModel> {
  static final _formKey = GlobalKey<FormState>();

  const ConfirmTransferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(24.0),
        children: [
          // CustomText.title(
          //   TranslationsKeys.tkFromAccountLabel,
          //   fontSize: 14.0,
          // ),
          // SizedBox(height: 8.0),
          // AccountItemTile(accountModel: controller.fromAccount!),
          // SizedBox(height: 24.0),
          CustomText.title(
            TranslationsKeys.tkToAccountLabel,
            fontSize: 14.0,
          ),
          SizedBox(height: 8.0),
          AccountItemTile(
            accountModel: controller.toAccount!,
            withName: true,
            withIban: false,
            withPhone: false,
          ),
          SizedBox(height: 24.0),
          AccountsDropDown(
            onSaved: controller.onFromAccountChanged,
            validator: (v) => InputsValidator.generalValidator(v?.toString()),
          ),
          SizedBox(height: 24.0),
          AmountInputField(
            onSaved: controller.onAmountChanged,
          ),
          SizedBox(height: 24),
          CustomFormField(
            label: TranslationsKeys.tkCommentsLabel,
            onSaved: controller.onCommentChanged,
            validator: InputsValidator.generalValidator,
            maxLines: 3,
          ),
          // CustomText.title(
          //   TranslationsKeys.tkTransactionInfoLabel,
          //   fontSize: 14.0,
          // ),
          // SizedBox(height: 8.0),
          // CustomCard(
          //   color: ColorManager.darkBackgroundColor,
          //   padding: EdgeInsets.all(12.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           CustomText.subtitle(
          //             TranslationsKeys.tkPhoneLabel,
          //             fontSize: 10.0,
          //           ),
          //           CustomText.title(
          //             controller.phone ?? '',
          //             fontSize: 12.0,
          //           ),
          //           SizedBox(height: 12.0),
          //           CustomText.subtitle(
          //             TranslationsKeys.tkCommentsLabel,
          //             fontSize: 10.0,
          //           ),
          //           CustomText.title(
          //             controller.comment ?? '',
          //             fontSize: 12.0,
          //           ),
          //         ],
          //       ),
          //       Spacer(),
          //       CustomText.title(
          //         controller.amount.toString(),
          //         fontSize: 24,
          //         color: ColorManager.primaryColor,
          //       ),
          //       SizedBox(width: 4.0),
          //       CustomText.subtitle(TranslationsKeys.tkSDGLabel),
          //     ],
          //   ),
          // ),
          SizedBox(height: 32.0),
          CustomButton(
            text: TranslationsKeys.tkConfirmBtn,
            onPressed: () => _confirm(context),
          )
        ],
      ),
    );
  }

  void _confirm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.toAccountBBan == null) {
        TransferActions.instance.transferInsideBank(context, onDone: onDone);
      } else {
        TransferActions.instance.transferOutsideBank(context, onDone: onDone);
      }
    }
  }

  void onDone() {
    _formKey.currentState!.reset();
    controller.clear();
  }
}
