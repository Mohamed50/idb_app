import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/actions/bill_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/controllers/tele_bills_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/tele_service_type.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/views/widgets/tele_provider_picker.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TelecommunicationServicePage extends GetView<TeleBillsViewModel> {
  static final _formKey = GlobalKey<FormState>();

  const TelecommunicationServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final verticalSpacing = 16.0;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(TranslationsKeys.tkBillPaymentTelecommunicationServicesLabel),
          bottom: TabBar(
            onTap: Get.find<TeleBillsViewModel>().onTypeChanged,
            labelColor: ColorManager.titleColor,
            labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: ColorManager.primaryColor,
            // indicator: BoxDecoration(color: ColorManager.primaryColor.withValues(alpha: 0.7), borderRadius: BorderRadius.circular(12.0)),
            tabs: [
              Tab(
                text: TeleServiceType.topUp.toLabel(),
              ),
              Tab(
                text: TeleServiceType.payment.toLabel(),
              ),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(24.0),
            children: [
              TeleProviderPicker(),
              SizedBox(height: verticalSpacing * 2),
              AccountsDropDown(
                onSaved: controller.onFromAccountChanged,
                validator: (v) => InputsValidator.generalValidator(v?.toString()),
              ),
              SizedBox(height: verticalSpacing),
              CustomFormField(
                label: TranslationsKeys.tkPhoneLabel,
                onSaved: controller.onPhoneChanged,
                validator: InputsValidator.phoneValidator,
              ),
              SizedBox(height: verticalSpacing),
              GetX<TeleBillsViewModel>(
                builder:(controller) =>  CustomVisible(
                  show: controller.selectedServiceType == TeleServiceType.topUp || controller.billInfoModel != null,
                  child: CustomFormField(
                    label: TranslationsKeys.tkAmountLabel,
                    onSaved: controller.onAmountChanged,
                    validator: InputsValidator.generalValidator,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              SizedBox(height: 64.0),
              CustomButton(
                text: TranslationsKeys.tkConfirmBtn,
                onPressed: () => _confirm(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _confirm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      BillsActions.instance.confirm(context);
    }
  }
}
