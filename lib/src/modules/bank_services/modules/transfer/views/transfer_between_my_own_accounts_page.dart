import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/actions/transfer_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/controllers/transfer_view_model.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:az_banking_app/src/views/custom/custom_button.dart';
import 'package:az_banking_app/src/views/custom/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferBetweenMyOwnAccountsPage extends GetView<TransferViewModel> {
  static final _formKey = GlobalKey<FormState>();

  const TransferBetweenMyOwnAccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final verticalSpacing = 16.0;
    return Scaffold(
      appBar: CustomAppbar(title: TranslationsKeys.tkTransferBetweenMyAccountsLabel),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(24.0),
          children: [
            AccountsDropDown(
              withOneAccountError: true,
              onChanged: (v) {
                controller.onFromAccountChanged(v);
                controller.onToAccountChanged(null);
              },
              validator: (v) => InputsValidator.generalValidator(v?.toString()),
            ),
            SizedBox(height: verticalSpacing),
            GetBuilder<TransferViewModel>(
              builder: (controller) => AccountsDropDown(
                value: controller.toAccount == controller.fromAccount ? null : controller.toAccount,
                label: TranslationsKeys.tkToAccountLabel,
                onSaved: controller.onToAccountChanged,
                validator: (v) => InputsValidator.generalValidator(v?.toString()),
                withOneAccountError: true,
                ignoreAccount: controller.fromAccount,
              ),
            ),
            SizedBox(height: verticalSpacing),
            CustomFormField(
              label: TranslationsKeys.tkAmountLabel,
              onSaved: controller.onAmountChanged,
              validator: InputsValidator.generalValidator,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
              inputFormatters: [AmountFormatter(maxDecimals: 2)],
            ),
            SizedBox(height: verticalSpacing),
            CustomFormField(
              label: TranslationsKeys.tkCommentsLabel,
              onSaved: controller.onCommentChanged,
              onFieldSubmitted: (value) => _transfer(context),
              maxLength: 50,
              maxLines: 1,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 64.0),
            CustomButton(
              text: TranslationsKeys.tkConfirmBtn,
              onPressed: () => _transfer(context),
            )
          ],
        ),
      ),
    );
  }

  void _transfer(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      TransferActions.instance.transferBetweenMyAccounts(
        context,
        onDone: () {
          _formKey.currentState!.reset();
          controller.clear();
        },
      );
    }
  }
}
