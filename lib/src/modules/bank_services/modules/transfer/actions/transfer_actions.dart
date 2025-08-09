import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/essentials/config/action_presenter.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/controllers/transfer_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/views/transfer_between_my_own_accounts_page.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/views/transfer_to_account_inside_bank_page.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TransferActions extends ActionPresenter {
  static final TransferActions _mInstance = TransferActions._();

  static TransferActions get instance => _mInstance;

  TransferActions._();

  void fetchReceiverInfo(BuildContext context) {
    actionHandler(context, () async {
      final controller = Get.find<TransferViewModel>();
      await controller.fetchReceiverInfo();
    });
  }

  void fetchReceiverInfoOutsideBank(BuildContext context) {
    actionHandler(context, () async {
      final controller = Get.find<TransferViewModel>();
      await controller.fetchReceiverInfoOutsideBank();
    });
  }

  void transferInsideBank(BuildContext context, {required VoidCallback onDone}) {
    actionHandler(context, () async {
      final controller = Get.find<TransferViewModel>();
      final response = await controller.transferToAccountInsideBank();
      _toResponsePage(response, BeneficiaryType.inside);
      onDone();
    });
  }

  void transferBetweenMyAccounts(BuildContext context, {required VoidCallback onDone}) {
    actionHandler(context, () async {
      final controller = Get.find<TransferViewModel>();
      if (!controller.isFromAndToSameAccount()) {
        final response = await controller.transferToAccountInsideBank();
        _toResponsePage(response, null);
        onDone();
      } else {
        throw AppException(TranslationsKeys.tkOneAccountErrorMsg);
      }
    });
  }

  void transferOutsideBank(BuildContext context, {required VoidCallback onDone}) {
    actionHandler(context, () async {
      final response = await Get.find<TransferViewModel>().transferToAccountOutsideBank();
      _toResponsePage(response, BeneficiaryType.outside);
      onDone();
    });
  }

  void transferUsingQrCode(BuildContext context) {
    actionHandler(context, () async {
      final response = await Get.find<TransferViewModel>().transferUsingQrCode();
      _toResponsePage(response, BeneficiaryType.inside);
    });
  }

  void _toResponsePage(Map<String, dynamic> response, BeneficiaryType? beneficiaryType) {
    Get.toNamed(RouteManager.responseRoute, arguments: {
      'response': response,
      'to_account': Get.find<TransferViewModel>().toAccount,
      'beneficiary_type': beneficiaryType,
    });
  }
}
