import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';

class FaqsService extends ApiService{

  Future<String> fetchFaqs() async{
    final response = await get(APIConfiguration.fetchFaqsUrl);
    return response.body['App_FAQs'] ?? '';
  }

}