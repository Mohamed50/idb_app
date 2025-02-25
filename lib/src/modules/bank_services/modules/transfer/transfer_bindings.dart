import 'package:az_banking_app/src/modules/bank_services/controllers/bank_services_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/services/bank_services.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/controllers/transfer_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/data/services/transfer_service.dart';
import 'package:get/get.dart';

class TransferBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransferService());
    Get.lazyPut(() => TransferViewModel(Get.find()));
  }
}
