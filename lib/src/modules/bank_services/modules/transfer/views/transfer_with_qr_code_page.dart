import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/actions/transfer_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/controllers/transfer_view_model.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'confirm_transfer_widget.dart';

class TransferWithQrCodePage extends GetView<TransferViewModel> {

  const TransferWithQrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onToAccountChanged(Get.arguments);
    return Scaffold(
      backgroundColor: ColorManager.lightBackgroundColor,
      appBar: CustomAppbar(title: TranslationsKeys.tkTransferOutsideBankServicesLabel),
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
            initialValue: controller.toAccount?.accountNo,
            enabled: false,
            label: TranslationsKeys.tkToAccountLabel,
            validator: InputsValidator.generalValidator,
          ),
          SizedBox(height: verticalSpacing),
          CustomFormField(
            label: TranslationsKeys.tkPhoneLabel,
            onSaved: controller.onPhoneChanged,
            validator: InputsValidator.generalValidator,
            keyboardType: TextInputType.number,
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


