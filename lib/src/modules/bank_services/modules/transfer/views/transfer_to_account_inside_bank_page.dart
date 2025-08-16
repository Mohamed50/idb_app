import 'package:az_banking_app/src/app.dart';
import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/actions/transfer_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/controllers/transfer_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/views/confirm_transfer_widget.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/views/beneficiary_drop_down.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:az_banking_app/src/views/custom/custom_button.dart';
import 'package:az_banking_app/src/views/custom/custom_form_field.dart';
import 'package:az_banking_app/src/views/custom/custom_visible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TransferToAccountInsideBankPage extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();

  const TransferToAccountInsideBankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: TranslationsKeys.tkTransferInsideBankLabel),
      body: Form(
        key: TransferToAccountInsideBankPage._formKey,
        child: GetBuilder<TransferViewModel>(
          builder: (controller) => CustomVisible(
            show: !controller.isInfoAvailable(),
            placeHolder: ConfirmTransferWidget(
              formKey: TransferToAccountInsideBankPage._formKey,
            ),
            child: InsideBankForm(
              formKey: TransferToAccountInsideBankPage._formKey,
            ),
          ),
        ),
      ),
    );
  }
}

class InsideBankForm extends GetView<TransferViewModel> {
  final GlobalKey<FormState> formKey;

  const InsideBankForm({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final verticalSpacing = 16.0;
    BeneficiaryModel? beneficiaryModel = Get.arguments?['beneficiary'];
    if (beneficiaryModel != null) {
      controller.numberController.text = beneficiaryModel.number;
    }
    return ListView(
      padding: EdgeInsets.all(24.0),
      children: [
        AccountsDropDown(
          onSaved: controller.onFromAccountChanged,
          validator: (v) => InputsValidator.generalValidator(v?.toString()),
        ),
        SizedBox(height: verticalSpacing),
        CustomFormField(
          label: TranslationsKeys.tkToAccountLabel,
          controller: controller.numberController,
          onSaved: controller.onToAccountNumberChanged,
          keyboardType: TextInputType.number,
          validator: InputsValidator.accountNumberValidator,
          inputFormatters: [LengthLimitingTextInputFormatter(11)],
        ),
        SizedBox(height: verticalSpacing),
        BeneficiaryDropDown(
          type: BeneficiaryType.inside,
          value: beneficiaryModel,
          onChanged: (value) {
            if (value != null) {
              controller.numberController.text = value.number;
              controller.onToAccountNumberChanged(value.number);
            }
          },
        ),
        SizedBox(height: 64.0),
        CustomButton(
          text: TranslationsKeys.tkConfirmBtn,
          onPressed: () => _transfer(context),
        )
      ],
    );
  }

  void _transfer(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      TransferActions.instance.fetchReceiverInfo(context);
    }
  }
}
