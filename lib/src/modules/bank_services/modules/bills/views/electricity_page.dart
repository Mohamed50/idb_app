import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/actions/bill_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/controllers/bill_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/controllers/electricity_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/service_config.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/views/beneficiary_drop_down.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ElectricityPage extends GetView<ElectricityViewModel> {
  static final _formKey = GlobalKey<FormState>();

  const ElectricityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: TranslationsKeys.tkBillPaymentElectricityServicesLabel,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          GetBuilder<ElectricityViewModel>(
            builder: (controller) => CustomVisible(
              show: controller.billInfoModel != null,
              placeHolder: Form(key: _formKey, child: _FormWidget()),
              child: _BillInformationWidget(),
            ),
          ),
          SizedBox(height: 24.0),
          CustomButton(
            text: TranslationsKeys.tkConfirmBtn,
            onPressed: () => _confirm(context),
          ),
        ],
      ),
    );
  }

  void _confirm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      BillsActions.instance.electricityConfirm(context, ServicesConfiguration.topUpElectricityServiceCode);
    }
  }
}

class _FormWidget extends GetView<ElectricityViewModel> {
  static final _numberController = TextEditingController();

  const _FormWidget();

  @override
  Widget build(BuildContext context) {
    final verticalSpacing = 16.0;
    BeneficiaryModel? beneficiaryModel = Get.arguments?['beneficiary'];
    _numberController.text = beneficiaryModel?.number ?? '';
    return Column(
      children: [
        SizedBox(height: verticalSpacing * 2),
        AccountsDropDown(
          onSaved: controller.onFromAccountChanged,
          validator: (v) => InputsValidator.generalValidator(v?.toString()),
        ),
        SizedBox(height: verticalSpacing),
        CustomFormField(
          controller: _numberController,
          label: TranslationsKeys.tkMeterNumberLabel,
          validator: InputsValidator.validateMeterNumber,
          onSaved: controller.onMeterNumberChanged,
          keyboardType: TextInputType.number,
          inputFormatters: [LengthLimitingTextInputFormatter(13)],
        ),
        SizedBox(height: verticalSpacing),
        BeneficiaryDropDown(
          type: BeneficiaryType.electricity,
          value: beneficiaryModel,
          onChanged: (value) {
            if (value != null) {
              _numberController.text = value.number;
            }
          },
        ),
        SizedBox(height: verticalSpacing),
        CustomFormField(
          label: TranslationsKeys.tkAmountLabel,
          onSaved: controller.onAmountChanged,
          validator: InputsValidator.validateAmount,
          keyboardType: TextInputType.number,
          inputFormatters: [AmountFormatter(maxIntegers: 7)],
        ),
      ],
    );
  }
}

class _BillInformationWidget extends GetView<BillsViewModel> {
  const _BillInformationWidget();

  @override
  Widget build(BuildContext context) {
    final children = ServicesConfiguration.getServiceResponseItems(controller.billInfoModel!);
    return CustomCard(
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.all(12.0),
        itemCount: children.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (context, index) => Divider(
          thickness: 0.2,
          color: ColorManager.titleColor,
        ),
      ),
    );
  }
}
