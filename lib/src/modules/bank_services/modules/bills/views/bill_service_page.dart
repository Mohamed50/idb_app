import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/actions/bill_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/controllers/bill_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/service_config.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
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
              placeHolder: Form(key: _formKey, child: _FormWidget(billerId)),
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

  const _FormWidget(this.billerId);

  @override
  Widget build(BuildContext context) {
    final verticalSpacing = 16.0;
    BeneficiaryModel? beneficiaryModel = Get.arguments?['beneficiary'];
    return Column(
      children: [
        SizedBox(height: verticalSpacing * 2),
        AccountsDropDown(
          onSaved: controller.onFromAccountChanged,
          validator: (v) => InputsValidator.generalValidator(v?.toString()),
        ),
        SizedBox(height: verticalSpacing),
        CustomFormField(
          initialValue: beneficiaryModel?.number,
          label: ServicesConfiguration.getServiceMainFiledLabel(billerId),
          onSaved: controller.onBillNumberChanged,
          validator: InputsValidator.generalValidator,
        ),
        SizedBox(height: verticalSpacing),
        CustomVisible(
          show: ServicesConfiguration.getServiceSecondaryFiledLabel(billerId) != null,
          child: CustomFormField(
            label: ServicesConfiguration.getServiceSecondaryFiledLabel(billerId),
            onSaved: controller.onSecondaryNumberChanged,
            validator: InputsValidator.generalValidator,
          ),
        ),
        SizedBox(height: verticalSpacing),
        CustomFormField(
          label: TranslationsKeys.tkAmountLabel,
          onSaved: controller.onAmountChanged,
          validator: InputsValidator.generalValidator,
          keyboardType: TextInputType.number,
          inputFormatters: [AmountFormatter()],
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
