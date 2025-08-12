import 'package:az_banking_app/src/modules/accounts/controllers/account_view_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/services/account_service.dart';
import 'package:az_banking_app/src/modules/statements/controllers/statement_view_model.dart';
import 'package:get/get.dart';

import 'controllers/link_account_view_model.dart';

class AccountBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountService());
    Get.lazyPut(() => AccountViewModel(Get.find(), onAccountChanged: onAccountChanged));
  }

  void onAccountChanged(AccountModel value) {
    Get.find<StatementViewModel>().accountChangeOnHomeNotifier(value);
  }
}

class LinkAccountBindings extends Bindings {
  @override
  void dependencies() {
    final userId = Get.arguments['userId'];
    final availableAccounts = Get.arguments['accounts'] ?? <AccountModel>[];
    final selectedAccounts = Get.isRegistered<AccountViewModel>() ? Get.find<AccountViewModel>().accounts.data ?? <AccountModel>[] : <AccountModel>[];
    Get.lazyPut(() => AccountService());
    Get.lazyPut(() => LinkAccountViewModel(Get.find(), userId, availableAccounts, selectedAccounts));
  }

}
