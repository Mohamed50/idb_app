import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/actions/order_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/controllers/order_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/data/models/pages_number_model.dart';
import 'package:az_banking_app/src/modules/branches/views/branches_drop_down.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/custom_drop_down.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestChequeBookPage extends GetView<OrderViewModel> {
  static final _formKey = GlobalKey<FormState>();

  const RequestChequeBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: TranslationsKeys.tkRequestChequeBookServiceLabel),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Form(key: _formKey, child: _FormWidget()),
            SizedBox(height: 64.0),
            CustomButton(
              text: TranslationsKeys.tkConfirmBtn,
              onPressed: () => _confirm(context),
            ),
          ],
        ),
      ),
    );
  }

  void _confirm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      OrderActions.instance.requestChequeBook(context);
    }
  }
}

class _FormWidget extends GetView<OrderViewModel> {
  const _FormWidget();

  @override
  Widget build(BuildContext context) {
    final verticalSpacing = 16.0;
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: verticalSpacing * 2),
          AccountsDropDown(
            onSaved: controller.onFromAccountChanged,
            validator: (v) => InputsValidator.generalValidator(v?.toString()),
          ),
          SizedBox(height: verticalSpacing),
          CustomDropDown<PagesNumberModel>(
            label: TranslationsKeys.tkChequeTypeLabel,
            options: [
              PagesNumberModel.smallBook(),
              PagesNumberModel.largeBook(),
            ],
            onSaved: controller.onPagesNumberChanged,
            validator: (value) => InputsValidator.generalValidator(value.toString()),
          ),
          SizedBox(height: verticalSpacing),
          BranchesDropDown(
            label: TranslationsKeys.tkReceivingBranchLabel,
            onSaved: controller.onReceivingBranchChanged,
            validator: (value) => InputsValidator.generalValidator(value.toString()),
          ),
        ],
      ),
    );
  }
}
