import 'package:az_banking_app/src/modules/information/controllers/information_view_model.dart';
import 'package:az_banking_app/src/modules/information/data/information_service.dart';
import 'package:get/get.dart';

class InformationBindings implements Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<InformationViewModel>()) {
      Get.lazyPut(() => InformationService());
      Get.put(InformationViewModel(Get.find()), permanent: true);
    }
  }
}