import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';

class InformationService extends ApiService {
  Future<String> fetchAboutUs() async {
    final response = await post(APIConfiguration.getAboutUsUrl, {}, headers: getUnauthorizedHeader());
    return response.body['Bank_About'];
  }

  Future<String> fetchContactInfo() async {
    final response = await post(APIConfiguration.getContactInfosUrl, {}, headers: getUnauthorizedHeader());
    return response.body['Bank_Contact'];
  }

  Future<String> fetchTermsAndConditions() async {
    final response = await post(APIConfiguration.getTermsAndConditionsUrl, {}, headers: getUnauthorizedHeader());
    return response.body['Bank_Terms'];
  }
}
