import 'package:az_banking_app/src/modules/bank_services/modules/orders/controllers/order_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/data/services/order_service.dart';
import 'package:az_banking_app/src/modules/branches/controllers/branches_view_model.dart';
import 'package:get/get.dart';

class OrdersBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderService());
    Get.lazyPut(() => OrderViewModel(Get.find()));
    Get.find<BranchesViewModel>().fetchBranches();
  }
}

