import 'package:az_banking_app/src/modules/faqs/controllers/faqs_view_model.dart';
import 'package:az_banking_app/src/modules/faqs/data/services/faqs_service.dart';
import 'package:get/get.dart';

class FaqsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FaqsService());
    Get.lazyPut(() => FaqsViewModel(Get.find()));
  }
}
