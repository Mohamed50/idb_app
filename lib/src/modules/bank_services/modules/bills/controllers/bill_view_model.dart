import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/services/bills_service.dart';
import 'package:get/get.dart';

class BillsViewModel extends GetxController {
  final BillsService _billsService;

  String? _billNumber, _secondaryNumber;
  double? amount;
  AccountModel? _fromAccount;

  BillsViewModel(this._billsService);

  Map<String, dynamic>? _billInfoModel;

  Map<String, dynamic>? get billInfoModel => _billInfoModel;

  Future<Map<String, dynamic>> billInquiry(String billerId) async {
    return await _billsService.billInquiry(billerId, _fromAccount!, _billNumber!, amount!, _secondaryNumber);
  }

  Future<Map<String, dynamic>> billPayment(String billerId) async {
    return await _billsService.billPayment(billerId, _fromAccount!, _billNumber!, amount!, _secondaryNumber);
  }

  void onFromAccountChanged(AccountModel? value) {
    _fromAccount = value;
  }

  void onBillNumberChanged(String? newValue) {
    _billNumber = newValue;
  }

  void onSecondaryNumberChanged(String? newValue) {
    _secondaryNumber = newValue;
  }

  void onAmountChanged(String? newValue) {
    amount = double.parse(newValue ?? '0');
  }

  void onBillInfoChanged(Map<String, dynamic> response) {
    _billInfoModel = response;
    update();
  }
}
