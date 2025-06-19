import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/actions/transfer_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/controllers/transfer_view_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/views/beneficiary_drop_down.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'confirm_transfer_widget.dart';

class TransferToAccountOutsideBankPage extends GetView<TransferViewModel> {

  const TransferToAccountOutsideBankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: TranslationsKeys.tkTransferOutsideBankServicesLabel),
      body: GetBuilder<TransferViewModel>(
        builder:(controller) => CustomVisible(
          show: !controller.isInfoAvailable(),
          placeHolder: ConfirmTransferWidget(),
          child: _OutsideBankForm(),
        ),
      ),
    );
  }


}


class _OutsideBankForm extends GetView<TransferViewModel> {
  static final _formKey = GlobalKey<FormState>();

  const _OutsideBankForm();

  @override
  Widget build(BuildContext context) {
    final verticalSpacing = 16.0;
    BeneficiaryModel? beneficiaryModel = Get.arguments?['beneficiary'];
    if(beneficiaryModel != null){
      controller.numberController.text = beneficiaryModel.number;
    }
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
            controller: controller.numberController,
            label: TranslationsKeys.tkToAccountBBANLabel,
            onSaved: controller.onToAccountBBANChanged,
            validator: InputsValidator.generalValidator,
          ),
          SizedBox(height: verticalSpacing),
          BeneficiaryDropDown(
            type: BeneficiaryType.outside,
            value: beneficiaryModel,
            onChanged: (value) {
              if(value != null) {
                controller.numberController.text = value.number;
                controller.onToAccountBBANChanged(value.number);
              }
            },
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
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      TransferActions.instance.fetchReceiverInfoOutsideBank(context);
    }
  }
}

