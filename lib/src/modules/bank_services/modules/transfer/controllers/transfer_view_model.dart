import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_type_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/data/services/transfer_service.dart';
import 'package:get/get.dart';

class TransferViewModel extends GetxController {
  final TransferService _transferService;

  // Constructor
  TransferViewModel(this._transferService);

  // Existing variables
  AccountModel? _fromAccount, toAccount;
  String? _phone, _comment, _toAccountBBan, _toAccountNumber;
  AccountType? _toAccountType;
  double? _amount;

  Future<Map<String, dynamic>> transferToAccountInsideBank() async {
    return await _transferService.transferToAccountInsideTheBank(
      _fromAccount!,
      toAccount!,
      _phone ?? '',
      _comment!,
      _amount!,
    );
  }

  Future<Map<String, dynamic>> transferToAccountOutsideBank() async {
    return await _transferService.transferToDifferentBank(
      _fromAccount!,
      _toAccountBBan!,
      _comment!,
      _amount!,
    );
  }

  Future<Map<String, dynamic>> transferUsingQrCode(String qrCode) async {
    return await _transferService.transferUsingQrCode(
      _fromAccount!,
      qrCode,
      _phone!,
      _comment!,
      _amount!,
    );
  }

  /// **Sets the selected 'From Account'**
  void onFromAccountChanged(AccountModel? account) {
    _fromAccount = account;
    update();
  }

  /// **Sets the selected 'To Account'**
  void onToAccountChanged(AccountModel? account) {
    toAccount = account;
    update();
  }

  /// **Sets the selected 'To Account'**
  void onToAccountBBANChanged(String? toAccountBBAN) {
    _toAccountBBan = toAccountBBAN;
    update();
  }

  /// **Updates the phone number**
  void onPhoneChanged(String? value) {
    _phone = value;
    update();
  }

  /// **Updates the comment**
  void onCommentChanged(String? value) {
    _comment = value;
    update();
  }

  /// **Updates the transfer amount**
  void onAmountChanged(String? value) {
    _amount = double.parse(value ?? '0');
    update();
  }

  void onToAccountNumberChanged(String? newValue) {
    _toAccountNumber = newValue;
    update();
  }

  void onToAccountTypeChanged(AccountType? newValue) {
    _toAccountType = newValue;
    update();
  }

  void setToAccount() {
    toAccount = AccountModel(accountType: _toAccountType!, accountNo: _toAccountNumber!);
  }

  bool isFromAndToSameAccount() {
    return _fromAccount == toAccount;
  }
}
