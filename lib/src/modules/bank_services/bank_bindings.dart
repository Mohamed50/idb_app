import 'package:az_banking_app/src/modules/bank_services/controllers/bank_services_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/services/bank_services.dart';
import 'package:get/get.dart';

class BankServiceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BankServicesService());
    Get.lazyPut(() => BankServicesViewModel(Get.find()));
  }
}
