import 'package:az_banking_app/src/modules/statements/controllers/statement_view_model.dart';
import 'package:az_banking_app/src/modules/statements/data/services/statement_service.dart';
import 'package:get/get.dart';

class StatementBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatementService());
    Get.lazyPut(() => StatementViewModel(Get.find()));
  }
}
