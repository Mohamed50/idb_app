import 'package:az_banking_app/src/modules/products/controllers/products_view_model.dart';
import 'package:az_banking_app/src/modules/products/data/services/product_service.dart';
import 'package:get/get.dart';

class ProductsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductService());
    Get.lazyPut(() => ProductsViewModel(Get.find()));
  }
}
