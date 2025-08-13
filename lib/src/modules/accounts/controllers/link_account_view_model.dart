import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/services/account_service.dart';
import 'package:get/get.dart';

class LinkAccountViewModel extends GetxController {
  final AccountService _accountService;
  final String userId;

  final List<AccountModel> availableAccounts;
  List<AccountModel> selectedAccounts;

  LinkAccountViewModel(this._accountService, this.userId, this.availableAccounts, this.selectedAccounts);

  ApiResponse<List<AccountModel>> _accounts = ApiResponse<List<AccountModel>>.idle();

  ApiResponse<List<AccountModel>> get accounts => _accounts;

  AccountModel? _primaryAccount;

  AccountModel? get primaryAccount => _primaryAccount;

  @override
  void onInit() {
    super.onInit();
    fetchAvailableAccounts();
  }

  Future<void> fetchAvailableAccounts() async {
    if (availableAccounts.isEmpty) {
      apiFetch(_accountService.getAvailableAccounts(userId)).listen((value) {
        _accounts = value;
        update();
      });
    } else {
      _accounts = ApiResponse.success(availableAccounts);
    }
  }

  Future<void> linkAccounts() async {
    await _accountService.linkAccounts(userId, selectedAccounts);
  }

  Future<void> unlinkAccounts() async {
    for (var e in accounts.data!) {
      e.isLinked = isSelected(e);
    }
    await _accountService.unlinkAccounts(userId, accounts.data!.where((e) => !e.isLinked).toList());
  }

  void onSelectAccount(AccountModel value) {
    if (selectedAccounts.contains(value)) {
      selectedAccounts.remove(value);
    } else {
      selectedAccounts.add(value);
    }
    update();
  }

  bool isSelected(AccountModel value) {
    return selectedAccounts.contains(value);
  }
}
