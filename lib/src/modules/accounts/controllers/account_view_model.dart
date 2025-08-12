import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/services/account_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AccountViewModel extends GetxController {
  final AccountService _accountService;
  final ValueChanged<AccountModel> onAccountChanged;

  AccountViewModel(this._accountService, {required this.onAccountChanged}) {
    _initialize();
  }

  final Rx<ApiResponse<List<AccountModel>>> _accounts = ApiResponse<List<AccountModel>>.idle().obs;

  ApiResponse<List<AccountModel>> get accounts => _accounts.value;

  AccountModel? _primaryAccount;

  AccountModel? get primaryAccount => _primaryAccount;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  AccountModel get selectedAccount => accounts.data![_selectedIndex];

  void _initialize() {
    _fetchAccounts();
  }

  void _fetchAccounts() {
    apiFetch(_accountService.fetchUserAccounts()).listen((value) {
      _accounts.value = value;
      if (value.status == ApiStatus.success) {
        _fetchBalance(value.data!);
      }
    });
  }

  void _fetchPrimaryAccount(List<AccountModel> accounts) {
    _primaryAccount = accounts.firstWhereOrNull((e) => e.isPrimary) ?? accounts.firstOrNull;
    onAccountChanged(_primaryAccount ?? accounts.first);
    update();
  }

  void _fetchBalance(List<AccountModel> accounts) {
    apiFetch(_accountService.fetchBalance(accounts)).listen((value) {
      _accounts.value = value;
      if (value.status == ApiStatus.success) {
        _fetchPrimaryAccount(value.data!);
      }
    });
  }

  void onSelectedAccountChange(AccountModel? value) {
    _primaryAccount = value;
    _selectedIndex = accounts.data!.indexWhere((e) => e.accountNo == value?.accountNo);
    update();
    if (value != null) {
      onAccountChanged(value);
    }
  }

  void onSelectedIndexChange(int index) {
    _selectedIndex = index;
    _primaryAccount = accounts.data![index];
    onAccountChanged(_primaryAccount!);
    update();
  }

  void refreshData() {
    _fetchAccounts();
  }
}
