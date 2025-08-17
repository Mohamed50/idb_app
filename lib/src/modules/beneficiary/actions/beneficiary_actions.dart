import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/beneficiary/beneficiaries_bindings.dart';
import 'package:az_banking_app/src/modules/beneficiary/controllers/add_beneficiary_view_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/controllers/beneficiary_view_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/controllers/edit_beneficiary_view_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/views/beneficiary_type_page.dart';
import 'package:az_banking_app/src/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/essentials/config/action_presenter.dart';

class BeneficiaryActions extends ActionPresenter {
  static final BeneficiaryActions _mInstance = BeneficiaryActions._();

  static BeneficiaryActions get instance => _mInstance;

  BeneficiaryActions._();

  Future addBeneficiary(BuildContext context, BeneficiaryModel beneficiaryModel) async {
    await actionHandler(context, () async {
      BeneficiariesBindings().dependencies();
      await Get.find<BeneficiaryViewModel>().addBeneficiary(beneficiaryModel);
      Get.find<BeneficiaryViewModel>().refreshData();
      showSuccessSnackBar(TranslationsKeys.tkBeneficiariesLabel, TranslationsKeys.tkAddBeneficiarySuccessMsg);
    });
  }

  Future addBeneficiaryFromPage(BuildContext context) async {
    await actionHandler(context, () async {
      BeneficiariesBindings().dependencies();
      if (!Get.find<AddBeneficiaryViewModel>().isReady()) {
        await Get.find<AddBeneficiaryViewModel>().fetchReceiverInfo();
        throw AppException(TranslationsKeys.tkAccountInfoConfirmationMsg);
      } else {
        await Get.find<BeneficiaryViewModel>().addBeneficiary(Get.find<AddBeneficiaryViewModel>().beneficiaryModel);
      }
      Get.find<BeneficiaryViewModel>().refreshData();
      Get.back();
      showSuccessSnackBar(TranslationsKeys.tkBeneficiariesLabel, TranslationsKeys.tkAddBeneficiarySuccessMsg);
    });
  }

  Future editBeneficiary(BuildContext context) async {
    await actionHandler(context, () async {
      BeneficiariesBindings().dependencies();
      if (!Get.find<EditBeneficiaryViewModel>().isReady()) {
        await Get.find<EditBeneficiaryViewModel>().fetchReceiverInfo();
        throw AppException(TranslationsKeys.tkAccountInfoConfirmationMsg);
      } else {
        await Get.find<BeneficiaryViewModel>().updateBeneficiary(Get.find<EditBeneficiaryViewModel>().beneficiaryModel);
      }
      Get.find<BeneficiaryViewModel>().refreshData();
      Get.back();
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

  void toAddBeneficiaryPage([BeneficiaryModel? beneficiaryModel]) {
    Get.find<BeneficiaryViewModel>().refreshData();
    Get.toNamed(RouteManager.beneficiaryAddRoute,
        arguments: beneficiaryModel ?? BeneficiaryModel(number: '', name: '', type: BeneficiaryType.inside));
  }

  void toEditBeneficiaryPage(BeneficiaryModel beneficiaryModel) {
    Get.find<BeneficiaryViewModel>().refreshData();
    Get.toNamed(
      RouteManager.beneficiaryEditRoute,
      arguments: beneficiaryModel,
    );
  }

  List<BeneficiaryModel> getBeneficiariesByType(BeneficiaryType type) {
    final controller = Get.find<BeneficiaryViewModel>();
    List<BeneficiaryModel> options = [];
    switch (type) {
      case BeneficiaryType.electricity:
        options = controller.electricityBeneficiaries;
        break;
      case BeneficiaryType.telecommunication:
        options = controller.teleBeneficiaries;
        break;
      case BeneficiaryType.inside:
        options = controller.insideBeneficiaries;
        break;
      case BeneficiaryType.outside:
        options = controller.outsideBeneficiaries;
        break;
    }
    return options;
  }

  void toBeneficiaryTypePage(BeneficiaryType type) {
    final beneficiaries = getBeneficiariesByType(type);
    Get.to(() => BeneficiaryTypePage(beneficiaries: beneficiaries));
  }

  void removeBeneficiary(BuildContext context, BeneficiaryModel beneficiaryModel) {
    actionHandler(context, () async {
      await Get.find<BeneficiaryViewModel>().removeBeneficiary(beneficiaryModel);
      Get.find<BeneficiaryViewModel>().refreshData();
    });
  }
}
