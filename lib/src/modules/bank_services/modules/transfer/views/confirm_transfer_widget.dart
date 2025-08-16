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
  final GlobalKey<FormState> formKey;

  const ConfirmTransferWidget( {super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(24.0),
      children: [
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
          maxLength: 50,
          onFieldSubmitted: (v) => _confirm(context),
          textInputAction: TextInputAction.done,
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
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (controller.toAccountBBan == null) {
        TransferActions.instance.transferInsideBank(context, onDone: onDone);
      } else {
        TransferActions.instance.transferOutsideBank(context, onDone: onDone);
      }
    }
  }

  void onDone() {
    formKey.currentState!.reset();
    controller.clear();
  }
}
