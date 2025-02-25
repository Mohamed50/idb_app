import 'package:az_banking_app/src/modules/accounts/controllers/account_view_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/services/account_service.dart';
import 'package:az_banking_app/src/modules/statements/controllers/statement_view_model.dart';
import 'package:get/get.dart';

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
