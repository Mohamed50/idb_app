import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/actions/bill_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/controllers/bill_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/service_config.dart';
import 'package:az_banking_app/src/modules/bank_services/views/amount_input_field.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/views/beneficiary_drop_down.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillServicePage extends GetView<BillsViewModel> {
  final String billServiceLabel;
  final String billerId;
  final String? inquiryBillerId;
  static final _formKey = GlobalKey<FormState>();

  const BillServicePage(this.billServiceLabel, this.billerId, {this.inquiryBillerId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: billServiceLabel,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          GetBuilder<BillsViewModel>(
            builder: (controller) => CustomVisible(
              show: controller.billInfoModel != null,
              placeHolder: Form(key: _formKey, child: _FormWidget(billerId, inquiryBillerId)),
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
    if (controller.billInfoModel == null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        BillsActions.instance.billConfirm(context, billerId, inquiryBillerId);
      }
    } else {
      BillsActions.instance.billConfirm(context, billerId, inquiryBillerId);
    }
  }

}

class _FormWidget extends GetView<BillsViewModel> {
  final String billerId;
  final String? inquiryBillerId;
  static final _numberController = TextEditingController();
  const _FormWidget(this.billerId, this.inquiryBillerId);

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
          label: ServicesConfiguration.getServiceMainFiledLabel(billerId),
          validator: ServicesConfiguration.getServiceMainFiledValidator(billerId),
          onSaved: controller.onBillNumberChanged,
          keyboardType: TextInputType.number,
        ),
        CustomVisible(
          show: billerId == ServicesConfiguration.topUpElectricityServiceCode,
          child: Padding(
            padding: EdgeInsets.only(top: verticalSpacing),
            child: BeneficiaryDropDown(
              type: BeneficiaryType.electricity,
              value: beneficiaryModel,
              onChanged: (value) {
                if(value != null) {
                  _numberController.text = value.number;
                }
              },
            ),
          ),
        ),
        CustomVisible(
          show: ServicesConfiguration.getServiceSecondaryFiledLabel(billerId) != null,
          child: Padding(
            padding: EdgeInsets.only(top: verticalSpacing),
            child: CustomFormField(
              label: ServicesConfiguration.getServiceSecondaryFiledLabel(billerId),
              validator: ServicesConfiguration.getServiceSecondaryFiledValidator(billerId),
              onSaved: controller.onSecondaryNumberChanged,
            ),
          ),
        ),
        SizedBox(height: verticalSpacing),
        CustomVisible(
          show: inquiryBillerId != ServicesConfiguration.billInquiryCustomsServiceCode,
          child: AmountInputField(
            onSaved: controller.onAmountChanged,
          ),
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
