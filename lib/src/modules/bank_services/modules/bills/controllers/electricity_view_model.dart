import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/services/bills_service.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/service_config.dart';
import 'package:get/get.dart';

class ElectricityViewModel extends GetxController {
  final BillsService _billsService;
  // final billerId = ServicesConfiguration.topUpElectricityServiceCode;
  final billerId = '2204';

  String? _meterNumber;
  double? amount;
  AccountModel? _fromAccount;

  ElectricityViewModel(this._billsService);

  Map<String, dynamic>? _billInfoModel;

  Map<String, dynamic>? get billInfoModel => _billInfoModel;

  Future<Map<String, dynamic>> billInquiry() async {
    return await _billsService.mockBillInquiry(billerId, _fromAccount!, _meterNumber!, amount!);
  }

  Future<Map<String, dynamic>> billPayment() async {
    return await _billsService.mockBillPayment(billerId, _fromAccount!, _meterNumber!, amount!);
  }

  void onFromAccountChanged(AccountModel? value) {
    _fromAccount = value;
  }

  void onMeterNumberChanged(String? newValue) {
    _meterNumber = newValue;
  }

  void onAmountChanged(String? newValue) {
    amount = double.parse(newValue ?? '0');
  }

  void onBillInfoChanged(Map<String, dynamic> response) {
    _billInfoModel = response;
    update();
  }
}
