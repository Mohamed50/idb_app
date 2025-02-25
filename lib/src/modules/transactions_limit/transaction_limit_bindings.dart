import 'package:az_banking_app/src/modules/transactions_limit/controllers/transactions_limit_view_model.dart';
import 'package:az_banking_app/src/modules/transactions_limit/data/services/transaction_limit_service.dart';
import 'package:get/get.dart';

class TransactionsLimitBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionsLimitService());
    Get.lazyPut(() => TransactionsLimitViewModel(Get.find()));
  }
}
