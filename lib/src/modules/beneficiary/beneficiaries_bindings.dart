import 'package:az_banking_app/src/modules/bank_services/modules/transfer/data/services/transfer_service.dart';
import 'package:az_banking_app/src/modules/beneficiary/controllers/add_beneficiary_view_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/controllers/beneficiary_view_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/services/beneficiary_service.dart';
import 'package:get/get.dart';

class BeneficiariesBindings implements Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<BeneficiaryViewModel>()) {
      Get.put(BeneficiaryService(), permanent: true);
      Get.put(BeneficiaryViewModel(Get.find()), permanent: true);
    }
  }
}

class AddBeneficiariesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransferService());
    Get.lazyPut(() => AddBeneficiaryViewModel(Get.find(), Get.arguments, Get.find()));
  }
}
