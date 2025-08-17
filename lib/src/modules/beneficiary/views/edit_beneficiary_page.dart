import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_list.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/tele_provider_enum.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/tele_service_type.dart';
import 'package:az_banking_app/src/modules/beneficiary/actions/beneficiary_actions.dart';
import 'package:az_banking_app/src/modules/beneficiary/controllers/edit_beneficiary_view_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:az_banking_app/src/utils/validator.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:az_banking_app/src/views/custom/custom_button.dart';
import 'package:az_banking_app/src/views/custom/custom_drop_down.dart';
import 'package:az_banking_app/src/views/custom/custom_form_field.dart';
import 'package:az_banking_app/src/views/custom/custom_visible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EditBeneficiaryPage extends GetView<EditBeneficiaryViewModel> {
  static final _formKey = GlobalKey<FormState>();

  const EditBeneficiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: TranslationsKeys.tkAddBeneficiaryLabel),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GetBuilder<EditBeneficiaryViewModel>(
                builder: (controller) => CustomFormField(
                  label: getNumberLabel(),
                  initialValue: controller.beneficiaryModel.number,
                  onChanged: controller.onNumberChanged,
                  validator: getNumberValidator(),
                  inputFormatters: getNumberInputFormatter(),
                ),
              ),
              SizedBox(height: 12.0),
              CustomFormField(
                label: TranslationsKeys.tkNameLabel,
                initialValue: controller.beneficiaryModel.name,
                onSaved: controller.onNameChanged,
                validator: InputsValidator.generalValidator,
              ),
              SizedBox(height: 12.0),
              CustomDropDown<BeneficiaryType>(
                label: TranslationsKeys.tkTypeLabel,
                value: controller.beneficiaryModel.type,
                onChanged: controller.onTypeChanged,
                validator: InputsValidator.generalValidator,
                options: [
                  BeneficiaryType.inside,
                  BeneficiaryType.outside,
                  BeneficiaryType.electricity,
                  BeneficiaryType.telecommunication,
                ],
              ),
              SizedBox(height: 12.0),
              GetBuilder<EditBeneficiaryViewModel>(
                builder: (controller) => CustomVisible(
                  show: controller.beneficiaryModel.type == BeneficiaryType.telecommunication,
                  child: CustomDropDown<TeleProvider>(
                    label: TranslationsKeys.tkTeleProviderLabel,
                    value: controller.beneficiaryModel.provider,
                    validator:InputsValidator.generalValidator,
                    onChanged: controller.onProviderChanged,
                    options: [
                      TeleProvider.zain,
                      TeleProvider.mtn,
                      TeleProvider.sudani,
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              GetBuilder<EditBeneficiaryViewModel>(
                builder: (controller) => CustomVisible(
                  show: controller.beneficiaryModel.type == BeneficiaryType.telecommunication,
                  child: CustomDropDown<TeleServiceType>(
                    label: TranslationsKeys.tkTeleServiceTypeLabel,
                    value: controller.beneficiaryModel.serviceType,
                    validator: InputsValidator.generalValidator,
                    onSaved: controller.onServiceTypeChanged,
                    options: [
                      TeleServiceType.topUp,
                      TeleServiceType.payment,
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              GetBuilder<EditBeneficiaryViewModel>(
                builder: (controller) => controller.toAccount != null
                    ? AccountItemTile(
                        accountModel: controller.toAccount!,
                        withName: true,
                      )
                    : Container(),
              ),
              Spacer(),
              CustomButton(
                text: TranslationsKeys.tkConfirmBtn,
                onPressed: () => _confirm(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await BeneficiaryActions.instance.editBeneficiary(context);
    }
  }

  String getNumberLabel() {
    switch (controller.beneficiaryModel.type) {
      case BeneficiaryType.electricity:
        return TranslationsKeys.tkMeterNumberLabel;
      case BeneficiaryType.telecommunication:
        return TranslationsKeys.tkPhoneLabel;
      case BeneficiaryType.inside:
        return TranslationsKeys.tkAccountNoLabel;
      case BeneficiaryType.outside:
        return TranslationsKeys.tkToAccountBBANLabel;
    }
  }

  String? Function(String? value)? getNumberValidator() {
    String? Function(String? value)? numberValidator = InputsValidator.generalValidator;
    switch (controller.beneficiaryModel.type) {
      case BeneficiaryType.electricity:
        break;
      case BeneficiaryType.telecommunication:
        numberValidator = controller.beneficiaryModel.provider == TeleProvider.sudani
            ? InputsValidator.sudaniValidator
            : controller.beneficiaryModel.provider == TeleProvider.zain
                ? InputsValidator.zainValidator
                : InputsValidator.mtnValidator;
        break;
      case BeneficiaryType.inside:
        numberValidator = InputsValidator.accountNumberValidator;
        break;
      case BeneficiaryType.outside:
        break;
    }
    return numberValidator;
  }

  List<TextInputFormatter> getNumberInputFormatter() {
    List<TextInputFormatter> inputFormatters = [];
    switch (controller.beneficiaryModel.type) {
      case BeneficiaryType.electricity:
        break;
      case BeneficiaryType.telecommunication:
        inputFormatters = [LengthLimitingTextInputFormatter(10)];
        break;
      case BeneficiaryType.inside:
        inputFormatters = [LengthLimitingTextInputFormatter(11)];
        break;
      case BeneficiaryType.outside:
        break;
    }
    return inputFormatters;
  }
}
