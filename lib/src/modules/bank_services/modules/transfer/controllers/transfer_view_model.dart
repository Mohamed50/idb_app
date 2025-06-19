import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_type_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/data/services/transfer_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferViewModel extends GetxController {
  final TransferService _transferService;

  // Constructor
  TransferViewModel(this._transferService);

  // Existing variables
  AccountModel? fromAccount, toAccount;
  String? phone, comment, toAccountBBan, _toAccountNumber;
  AccountType? _toAccountType = AccountType.ntd;
  double? amount;

  final TextEditingController numberController = TextEditingController();

  Future<Map<String, dynamic>> transferToAccountInsideBank() async {
    return await _transferService.transferToAccountInsideTheBank(
      fromAccount!,
      toAccount!,
      phone ?? '',
      comment!,
      amount!,
    );
  }

  Future<Map<String, dynamic>> transferToAccountOutsideBank() async {
    return await _transferService.transferToDifferentBank(
      fromAccount!,
      toAccountBBan!,
      comment!,
      amount!,
    );
  }

  Future<Map<String, dynamic>> transferUsingQrCode() async {
    return await transferToAccountInsideBank();
  }

  bool isInfoAvailable() {
    return toAccount?.name != null && toAccount!.name.isNotEmpty;
  }

  Future fetchReceiverInfo() async {
    toAccount = await _transferService.fetchAccountInfoInsideBank(
        _toAccountNumber ?? toAccount!.accountNo, _toAccountType?.toCode() ?? toAccount!.accountType.toCode());
    update();
  }

  Future fetchReceiverInfoOutsideBank() async {
    toAccount = await _transferService.fetchAccountInfoOutsideBank(toAccountBBan!);
    update();
  }

  /// **Sets the selected 'From Account'**
  void onFromAccountChanged(AccountModel? account) {
    fromAccount = account;
    update();
  }

  /// **Sets the selected 'To Account'**
  void onToAccountChanged(AccountModel? account) {
    toAccount = account;
    update();
  }

  /// **Sets the selected 'To Account'**
  void onToAccountBBANChanged(String? toAccountBBAN) {
    toAccountBBan = toAccountBBAN;
    update();
  }

  /// **Updates the phone number**
  void onPhoneChanged(String? value) {
    phone = value;
    update();
  }

  /// **Updates the comment**
  void onCommentChanged(String? value) {
    comment = value;
    update();
  }

  /// **Updates the transfer amount**
  void onAmountChanged(String? value) {
    amount = double.parse(value ?? '0');
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

  bool isFromAndToSameAccount() {
    return fromAccount == toAccount;
  }
}
