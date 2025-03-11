import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/beneficiary/beneficiaries_bindings.dart';
import 'package:az_banking_app/src/modules/beneficiary/controllers/beneficiary_view_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:az_banking_app/src/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/essentials/config/action_presenter.dart';

class BeneficiaryActions extends ActionPresenter {
  static final BeneficiaryActions _mInstance = BeneficiaryActions._();

  static BeneficiaryActions get instance => _mInstance;

  BeneficiaryActions._();

  Future addBeneficiary(BuildContext context, BeneficiaryModel beneficiaryModel) async {
    actionHandler(context, () async {
      BeneficiariesBindings().dependencies();
      Get.find<BeneficiaryViewModel>().addBeneficiary(beneficiaryModel);
      showSuccessSnackBar(TranslationsKeys.tkBeneficiariesLabel, TranslationsKeys.tkAddBeneficiarySuccessMsg);
    });
  }

  void toBeneficiaryTransactionPage(BeneficiaryModel beneficiaryModel) {
    switch (beneficiaryModel.type) {
      case BeneficiaryType.electricity:
        Get.toNamed(RouteManager.electricityPaymentRoute, arguments: {'beneficiary': beneficiaryModel});
        break;
      case BeneficiaryType.telecommunication:
        Get.toNamed(RouteManager.teleBillPaymentRoute, arguments: {'beneficiary': beneficiaryModel});
        break;
      case BeneficiaryType.inside:
        Get.toNamed(RouteManager.transferToAccountInsideBankRoute, arguments: {'beneficiary': beneficiaryModel});
        break;
      case BeneficiaryType.outside:
        Get.toNamed(RouteManager.transferToAccountOutsideBankRoute, arguments: {'beneficiary': beneficiaryModel});
        break;
    }
  }
}
