import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/actions/bill_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/controllers/tele_bills_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/bill_info_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/tele_service_type.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/views/widgets/tele_provider_picker.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
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
    BeneficiaryModel? beneficiaryModel = Get.arguments?['beneficiary'];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.primaryColor,
          title: CustomText.title(TranslationsKeys.tkBillPaymentTelecommunicationServicesLabel, color: ColorManager.onButtonColor,),
          bottom: TabBar(
            onTap: Get.find<TeleBillsViewModel>().onTypeChanged,
            labelColor: ColorManager.onButtonColor,
            labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0, color: Colors.grey[200]),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: ColorManager.onButtonColor,
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
                initialValue: beneficiaryModel?.number,
                label: TranslationsKeys.tkPhoneLabel,
                onSaved: controller.onPhoneChanged,
                validator: InputsValidator.phoneValidator,
              ),
              SizedBox(height: verticalSpacing),
              GetX<TeleBillsViewModel>(
                builder: (controller) => CustomVisible(
                  show: controller.selectedServiceType == TeleServiceType.topUp || controller.amount.value > 0,
                  child: CustomFormField(
                    initialValue: controller.amount > 0 ? controller.amount.toString() : null,
                    // enabled: controller.selectedServiceType == TeleServiceType.topUp,
                    label: TranslationsKeys.tkAmountLabel,
                    onSaved: controller.onAmountChanged,
                    validator: InputsValidator.generalValidator,
                    keyboardType: TextInputType.number,
                    inputFormatters: [AmountFormatter()],
                  ),
                ),
              ),
              SizedBox(height: verticalSpacing),
              BillInformationWidget(),
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

class BillInformationWidget extends StatelessWidget {
  const BillInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<TeleBillsViewModel>(
      builder: (controller) => CustomVisible(
        show: controller.selectedServiceType == TeleServiceType.payment && controller.billInfoModel.isNotEmpty,
        child: CustomCard(
          padding: EdgeInsets.all(12.0),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.billInfoModel.length,
            itemBuilder: (context, index) => BillInfoItemTile(billInfoModel: controller.billInfoModel[index]),
            separatorBuilder: (context, index) => SizedBox(height: 8.0),
          ),
        ),
      ),
    );
  }
}

class BillInfoItemTile extends StatelessWidget {
  final BillInfoModel billInfoModel;

  const BillInfoItemTile({super.key, required this.billInfoModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.subtitle(
          billInfoModel.label,
          fontSize: 10.0,
        ),
        CustomText.title(
          billInfoModel.value.toString(),
          fontSize: 12.0,
        ),
      ],
    );
  }
}
