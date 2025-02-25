import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/exchange_rate/data/models/exchange_rate_model.dart';

class ExchangeService extends ApiService {
  Future<List<ExchangeRateModel>> fetchExchangeRate() async {
      final response = await get(APIConfiguration.fetchExchangeRangeUrl);
      return exchangeRateModelFromJson(response.body['Currencies_List']);
  }
}
