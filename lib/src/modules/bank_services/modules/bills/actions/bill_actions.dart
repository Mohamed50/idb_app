import 'package:az_banking_app/src/essentials/config/action_presenter.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/controllers/bill_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/controllers/electricity_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/controllers/tele_bills_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/tele_service_type.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/service_config.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BillsActions extends ActionPresenter {
  static final BillsActions _mInstance = BillsActions._();

  static BillsActions get instance => _mInstance;

  BillsActions._();

  void teleBillInquiry(BuildContext context) {
    actionHandler(context, () async {
      final controller = Get.find<TeleBillsViewModel>();
      final response = await controller.billInquiry();
      final amount =
          response.firstWhere((e) => e.label.toLowerCase().contains('amount') || e.label.contains('المبلغ الكلي')).value;
      controller.onBillInformationChanged(response);
      controller.onAmountChanged(amount);
    });
  }

  void teleBillPayment(BuildContext context) {
    actionHandler(context, () async {
      final controller = Get.find<TeleBillsViewModel>();
      final response = await controller.billPayment();
      _toResponsePage(response, BeneficiaryType.telecommunication);
    });
  }

  void topUp(BuildContext context) {
    actionHandler(context, () async {
      final controller = Get.find<TeleBillsViewModel>();
      final response = await controller.topUp();
      _toResponsePage(response, BeneficiaryType.telecommunication);
    });
  }

  void confirm(BuildContext context) {
    final controller = Get.find<TeleBillsViewModel>();
    if (controller.selectedServiceType == TeleServiceType.topUp) {
      topUp(context);
    } else if (controller.billInfoModel.isNotEmpty) {
      teleBillPayment(context);
    } else {
      teleBillInquiry(context);
    }
  }

  void billConfirm(BuildContext context, String billerId, [String? inquiryBillerId]) {
    final controller = Get.find<BillsViewModel>();
    if (controller.billInfoModel != null) {
      billPayment(context, billerId);
    } else {
      billInquiry(context, inquiryBillerId ?? billerId);
    }
  }

  void electricityConfirm(BuildContext context, String billerId, [String? inquiryBillerId]) {
    actionHandler(context, () async {
      final controller = Get.find<ElectricityViewModel>();
      if (controller.billInfoModel != null) {
      final response = await controller.billPayment();
      _toResponsePage(
        response,
        billerId == ServicesConfiguration.topUpElectricityServiceCode ? BeneficiaryType.electricity : null,
      );
      } else {
        final response = await controller.billInquiry();
        controller.onBillInfoChanged(response);
      }
    });
  }

  void billInquiry(BuildContext context, String billerId) {
    actionHandler(context, () async {
      final controller = Get.find<BillsViewModel>();
      final response = await controller.billInquiry(billerId);
      controller.onBillInfoChanged(response);
    });
  }

  void billPayment(BuildContext context, String billerId) {
    actionHandler(context, () async {
      final controller = Get.find<BillsViewModel>();
      final response = await controller.billPayment(billerId);
      _toResponsePage(
        response,
        billerId == ServicesConfiguration.topUpElectricityServiceCode ? BeneficiaryType.electricity : null,
      );
    });
  }

  void _toResponsePage(Map<String, dynamic> response, BeneficiaryType? beneficiaryType) {
    Get.toNamed(RouteManager.responseRoute, arguments: {
      'response': response,
      'beneficiary_type': beneficiaryType,
    });
  }
}
