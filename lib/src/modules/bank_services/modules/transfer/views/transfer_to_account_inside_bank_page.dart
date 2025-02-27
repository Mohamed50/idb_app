import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/account_type_drop_down.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_list.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/actions/transfer_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/controllers/transfer_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/views/confirm_transfer_widget.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:az_banking_app/src/views/custom/custom_button.dart';
import 'package:az_banking_app/src/views/custom/custom_container.dart';
import 'package:az_banking_app/src/views/custom/custom_form_field.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:az_banking_app/src/views/custom/custom_visible.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferToAccountInsideBankPage extends StatelessWidget {
  const TransferToAccountInsideBankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: TranslationsKeys.tkTransferInsideBankLabel),
      body: GetBuilder<TransferViewModel>(
        builder:(controller) => CustomVisible(
          show: !controller.isInfoAvailable(),
          placeHolder: ConfirmTransferWidget(),
          child: _InsideBankForm(),
        ),
      ),
    );
  }
}

class _InsideBankForm extends GetView<TransferViewModel> {
  static final _formKey = GlobalKey<FormState>();

  const _InsideBankForm();

  @override
  Widget build(BuildContext context) {
    final verticalSpacing = 16.0;
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(24.0),
        children: [
          AccountsDropDown(
            onSaved: controller.onFromAccountChanged,
            validator: (v) => InputsValidator.generalValidator(v?.toString()),
          ),
          SizedBox(height: verticalSpacing),
          CustomFormField(
            label: TranslationsKeys.tkToAccountLabel,
            onSaved: controller.onToAccountNumberChanged,
            validator: InputsValidator.generalValidator,
          ),
          SizedBox(height: verticalSpacing),
          AccountTypeDropDown(
            label: TranslationsKeys.tkToAccountTypeLabel,
            onSaved: controller.onToAccountTypeChanged,
            validator: (v) => InputsValidator.generalValidator(v?.toString()),
          ),
          SizedBox(height: verticalSpacing),
          CustomFormField(
            label: TranslationsKeys.tkPhoneLabel,
            onSaved: controller.onPhoneChanged,
            validator: InputsValidator.phoneValidator,
          ),
          SizedBox(height: verticalSpacing),
          CustomFormField(
            label: TranslationsKeys.tkAmountLabel,
            onSaved: controller.onAmountChanged,
            validator: InputsValidator.generalValidator,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: verticalSpacing),
          CustomFormField(
            label: TranslationsKeys.tkCommentsLabel,
            onSaved: controller.onCommentChanged,
            validator: InputsValidator.generalValidator,
            maxLines: 3,
          ),
          SizedBox(height: 64.0),
          CustomButton(
            text: TranslationsKeys.tkConfirmBtn,
            onPressed: () => _transfer(context),
          )
        ],
      ),
    );
  }

  void _transfer(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      TransferActions.instance.fetchReceiverInfo(context);
    }
  }
}
