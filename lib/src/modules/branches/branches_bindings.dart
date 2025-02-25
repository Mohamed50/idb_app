import 'package:az_banking_app/src/modules/branches/controllers/branches_view_model.dart';
import 'package:az_banking_app/src/modules/branches/data/services/branches_services.dart';
import 'package:get/get.dart';

class BranchesBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(BranchesService());
    Get.put(BranchesViewModel(Get.find()), permanent: true);
  }
}
