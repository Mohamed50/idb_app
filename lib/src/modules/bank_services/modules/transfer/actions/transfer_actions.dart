import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/essentials/config/action_presenter.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/controllers/transfer_view_model.dart';
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

  void transferInsideBank(BuildContext context) {
    actionHandler(context, () async {
      final controller = Get.find<TransferViewModel>();
      final response = await controller.transferToAccountInsideBank();
      _toResponsePage(response);
    });
  }

  void transferBetweenMyAccounts(BuildContext context) {
    actionHandler(context, () async {
      final controller = Get.find<TransferViewModel>();
      if (!controller.isFromAndToSameAccount()) {
        final response = await controller.transferToAccountInsideBank();
        _toResponsePage(response);
      } else {
        throw AppException(TranslationsKeys.tkOneAccountErrorMsg);
      }
    });
  }

  void transferOutsideBank(BuildContext context) {
    actionHandler(context, () async {
      final response = await Get.find<TransferViewModel>().transferToAccountOutsideBank();
      _toResponsePage(response);
    });
  }

  void transferUsingQrCode(BuildContext context) {
    actionHandler(context, () async {
      final response = await Get.find<TransferViewModel>().transferUsingQrCode();
      _toResponsePage(response);
    });
  }

  void _toResponsePage(Map<String, dynamic> response) {
    Get.toNamed(RouteManager.responseRoute, arguments: response);
  }
}
