import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/exchange_rate/data/models/exchange_rate_model.dart';
import 'package:az_banking_app/src/modules/exchange_rate/data/services/exchange_service.dart';
import 'package:get/get.dart';

class ExchangeRateViewModel extends GetxController {
  final ExchangeService _exchangeService;

  final Rx<ApiResponse<List<ExchangeRateModel>>> _exchangeRates = ApiResponse<List<ExchangeRateModel>>.idle().obs;

  ApiResponse<List<ExchangeRateModel>> get exchangeRates => _exchangeRates.value;

  ExchangeRateViewModel(this._exchangeService) {
    _initialize();
  }

  void _initialize() {
    _fetchProducts();
  }

  void _fetchProducts() {
    apiFetch(_exchangeService.fetchExchangeRate()).listen((value) => _exchangeRates.value = value);
  }
}
