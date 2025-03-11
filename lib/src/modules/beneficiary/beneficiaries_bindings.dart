import 'package:az_banking_app/src/modules/beneficiary/controllers/beneficiary_view_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/services/beneficiary_service.dart';
import 'package:get/get.dart';

class BeneficiariesBindings implements Bindings {
  @override
  void dependencies() {
    if(!Get.isRegistered<BeneficiaryViewModel>()) {
      Get.put(BeneficiaryService());
      Get.put(BeneficiaryViewModel(Get.find()));
    }
  }
}
