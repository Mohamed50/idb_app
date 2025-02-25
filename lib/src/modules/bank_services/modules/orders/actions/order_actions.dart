import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/essentials/config/action_presenter.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/controllers/order_view_model.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderActions extends ActionPresenter {
  static final OrderActions _mInstance = OrderActions._();

  static OrderActions get instance => _mInstance;

  OrderActions._();


  void fetchChequeStatus(BuildContext context) {
    actionHandler(context, () async {
      final controller = Get.find<OrderViewModel>();
      final response = await controller.fetchChequeStatus();
      _toResponsePage(response);
    });
  }

  void requestChequeBook(BuildContext context) {
    actionHandler(context, () async {
      final controller = Get.find<OrderViewModel>();
      final response = await controller.requestChequeBook();
      back();
      showSuccessSnackBar(TranslationsKeys.tkRequestChequeBookServiceLabel, response['Response_Message']);
    });
  }


  void _toResponsePage(Map<String, dynamic> response) {
    Get.toNamed(RouteManager.responseRoute, arguments: response);
  }
}
