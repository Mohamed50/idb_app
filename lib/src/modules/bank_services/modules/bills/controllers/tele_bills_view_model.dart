import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/bill_info_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/tele_provider_enum.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/tele_service_type.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/services/tele_bills_service.dart';
import 'package:get/get.dart';

class TeleBillsViewModel extends GetxController {
  final TeleBillsService _teleBillsService;

  String? _phoneNumber;
  double? amount;
  AccountModel? _fromAccount;

  TeleBillsViewModel(this._teleBillsService);

  final Rx<TeleProvider> _selectedProvider = TeleProvider.zain.obs;

  TeleProvider get selectedProvider => _selectedProvider.value;

  final Rx<TeleServiceType> _selectedServiceType = TeleServiceType.topUp.obs;

  TeleServiceType get selectedServiceType => _selectedServiceType.value;

  Map<String, dynamic>? _billInfoModel;

  Map<String, dynamic>? get billInfoModel => _billInfoModel;

  Future<Map<String, dynamic>> topUp() async {
    switch (_selectedProvider.value) {
      case TeleProvider.zain:
        return await _teleBillsService.topUpZain(_fromAccount!, _phoneNumber!, amount!);
      case TeleProvider.mtn:
        return await _teleBillsService.topUpMtn(_fromAccount!, _phoneNumber!, amount!);
      case TeleProvider.sudani:
        return await _teleBillsService.topUpSudani(_fromAccount!, _phoneNumber!, amount!);
    }
  }

  Future<Map<String, dynamic>> billInquiry() async {
    switch (_selectedProvider.value) {
      case TeleProvider.zain:
        return await _teleBillsService.billInquiryZain(_fromAccount!, _phoneNumber!);
      case TeleProvider.mtn:
        return await _teleBillsService.billInquiryMtn(_fromAccount!, _phoneNumber!);
      case TeleProvider.sudani:
        return await _teleBillsService.billInquirySudani(_fromAccount!, _phoneNumber!);
    }
  }

  Future<Map<String, dynamic>> billPayment() async {
    switch (_selectedProvider.value) {
      case TeleProvider.zain:
        return await _teleBillsService.billPaymentZain(_fromAccount!, _phoneNumber!, amount!);
      case TeleProvider.mtn:
        return await _teleBillsService.billPaymentMtn(_fromAccount!, _phoneNumber!, amount!);
      case TeleProvider.sudani:
        return await _teleBillsService.billPaymentSudani(_fromAccount!, _phoneNumber!, amount!);
    }
  }

  void onProviderChange(TeleProvider teleProvider) {
    _selectedProvider.value = teleProvider;
  }

  void onTypeChanged(int? index) {
    _selectedServiceType.value = index == 0 ? TeleServiceType.topUp : TeleServiceType.payment;
  }

  void onFromAccountChanged(AccountModel? value) {
    _fromAccount = value;
  }

  void onPhoneChanged(String? newValue) {
    _phoneNumber = newValue;
  }

  void onAmountChanged(String? newValue) {
    amount = double.parse(newValue ?? '0');
  }

  void onBillInformationChanged(Map<String,dynamic>? newValue) {
    _billInfoModel = newValue;
    update();
  }
}
