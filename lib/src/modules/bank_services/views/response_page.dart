import 'dart:typed_data';
import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_list.dart';
import 'package:az_banking_app/src/modules/bank_services/actions/bank_service_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/service_config.dart';
import 'package:az_banking_app/src/modules/beneficiary/actions/beneficiary_actions.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:az_banking_app/src/views/custom/custom_button.dart';
import 'package:az_banking_app/src/views/custom/custom_container.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:az_banking_app/src/views/custom/custom_visible.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class ResponsePage extends StatelessWidget {
  static final screenshotController = ScreenshotController();

  const ResponsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> response = Get.arguments['response'] ?? Get.arguments ?? {};
    final children = ServicesConfiguration.getServiceResponseItems(response);
    final responseInJson = ServicesConfiguration.getServiceResponse(response);
    final AccountModel? toAccount = Get.arguments['to_account'];
    final BeneficiaryType? beneficiaryType = Get.arguments['beneficiary_type'];
    final Map<String, dynamic> info = getInfoMap(beneficiaryType, toAccount, responseInJson);
    return Scaffold(
      backgroundColor: ColorManager.darkBackgroundColor,
      appBar: CustomAppbar(
        title: TranslationsKeys.appName,
        actions: [
          InkWell(
            onTap: _share,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: FaIcon(FontAwesomeIcons.shareNodes),
            ),
          )
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          color: ColorManager.darkBackgroundColor,
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              SizedBox(height: 76.0),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  CustomCard(
                    color: ColorManager.lightBackgroundColor,
                    child: Column(
                      children: [
                        SizedBox(height: 52 + 24),
                        CustomText.title(
                          TranslationsKeys.tkSuccessLabel,
                        ),
                        CustomText.title(
                          TranslationsKeys.tkSuccessfulTransactionMsg,
                          fontSize: 12,
                        ),
                        SizedBox(height: 24.0),
                        ListView.separated(
                          padding: EdgeInsets.all(12.0),
                          shrinkWrap: true,
                          itemCount: children.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => children[index],
                          separatorBuilder: (context, index) => Divider(
                            color: ColorManager.titleColor,
                            thickness: 0.2,
                          ),
                        ),
                        toAccount != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: AccountItemTile(
                                  accountModel: toAccount,
                                  withName: true,
                                  withPhone: false,
                                  withIban: false,
                                  backgroundColor: ColorManager.lightBackgroundColor,
                                ),
                              )
                            : Container(),
                        SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -72,
                    child: Container(
                      padding: EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: ColorManager.cardGradient,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.lightBackgroundColor,
                        ),
                        padding: EdgeInsets.all(12.0),
                        child: Image.asset(
                          AssetsManager.logoPath,
                          width: 80.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              CustomButton(
                text: TranslationsKeys.tkDoneLabel,
                onPressed: () => _done(),
              ),
              SizedBox(height: 12),
              CustomButton(
                text: TranslationsKeys.tkAnotherTransactionLabel,
                onPressed: () => _back(),
              ),
              SizedBox(height: 12),
              CustomVisible(show: beneficiaryType != null, child: SizedBox(height: 12)),
              CustomVisible(
                show: beneficiaryType != null,
                child: CustomButton(
                  text: TranslationsKeys.tkAddBeneficiaryLabel,
                  onPressed: () => _addBeneficiary(context, info, beneficiaryType!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _done() {
    BankServicesActions.instance.done();
  }

  Future<void> _share() async {
    Uint8List? image = await screenshotController.capture();
    BankServicesActions.instance.share(image);
  }

  Future<void> _screenshot() async {
    Uint8List? image = await screenshotController.capture();
    BankServicesActions.instance.screenshot(image);
  }

  void _addBeneficiary(BuildContext context, Map info, BeneficiaryType beneficiaryType) {
    BeneficiaryModel beneficiaryModel;
    switch (beneficiaryType) {
      case BeneficiaryType.electricity:
        beneficiaryModel = BeneficiaryModel(number: info['number'], name: info['name'], type: BeneficiaryType.electricity);
        break;
      case BeneficiaryType.telecommunication:
        beneficiaryModel = BeneficiaryModel(number: info['number'], name: info['name'], type: BeneficiaryType.telecommunication);
        break;
      case BeneficiaryType.inside:
        beneficiaryModel = BeneficiaryModel(number: info['Account_No'], name: info['Custom_Name'], type: BeneficiaryType.inside);
        break;
      case BeneficiaryType.outside:
        beneficiaryModel = BeneficiaryModel(number: info['IBAN'], name: info['Custom_Name'], type: BeneficiaryType.outside);
        break;
    }
    BeneficiaryActions.instance.toAddBeneficiaryPage(beneficiaryModel);
  }

  Map<String, dynamic> getInfoMap(BeneficiaryType? type, AccountModel? accountModel, Map<String, dynamic> response) {
    switch (type) {
      case BeneficiaryType.electricity:
        return {
          'name': response['اسم العميل'] ?? response['Customer Name'],
          'number': response['رقم العداد'] ?? response['tkMeterNumberLabel']
        };
      case BeneficiaryType.telecommunication:
        return {'name': '', 'number': response['tkPhoneLabel']};
      case BeneficiaryType.inside:
        return accountModel!.toJson();
      case BeneficiaryType.outside:
        return accountModel!.toJson();
      default:
        return {};
    }
  }

  void _back() {
    BankServicesActions.instance.back();
  }
}

class ActionItem extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String label;

  const ActionItem({super.key, required this.iconData, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          FaIcon(
            iconData,
            size: 20,
          ),
          SizedBox(width: 4.0),
          CustomText.title(label, fontSize: 14),
        ],
      ),
    );
  }
}
