import 'package:az_banking_app/src/modules/exchange_rate/controllers/exchange_rate_view_model.dart';
import 'package:az_banking_app/src/modules/exchange_rate/data/services/exchange_service.dart';
import 'package:get/get.dart';

class ExchangeRateBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExchangeService());
    Get.lazyPut(() => ExchangeRateViewModel(Get.find()));
  }
}
