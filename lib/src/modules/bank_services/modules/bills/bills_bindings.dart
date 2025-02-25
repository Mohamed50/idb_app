import 'package:az_banking_app/src/modules/bank_services/controllers/bank_services_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/services/bank_services.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/controllers/bill_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/controllers/tele_bills_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/services/bills_service.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/services/tele_bills_service.dart';
import 'package:get/get.dart';

class TeleBillsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeleBillsService());
    Get.lazyPut(() => TeleBillsViewModel(Get.find()));
  }
}

class BillsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BillsService());
    Get.lazyPut(() => BillsViewModel(Get.find()));
  }
}
