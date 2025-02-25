import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';

class BillsService extends ApiService {



  Future<Map<String,dynamic>> billInquiry(String billerId, AccountModel fromAccount, String billNumber, double? amount, String? secondaryNumber) async {
    final body = {
      'Biller_ID': billerId,
      'Pay_Customer_Code': billNumber,
      'Additional_Reference': secondaryNumber ?? '',
      'Amount': amount ?? '',
      'Account_Info': fromAccount.toJson()
    };
    final response = await post(APIConfiguration.teleBillInquiryUrl, body);
    return response.body;
  }

  Future<Map<String, dynamic>> billPayment(String billerId, AccountModel fromAccount, String billNumber, double amount, String? secondaryNumber) async {
    final body = {
      'Biller_ID': billerId,
      'Pay_Customer_Code': billNumber,
      'Additional_Reference': secondaryNumber ?? '',
      'Amount': amount,
      'Account_Info': fromAccount.toJson()
    };
    final response = await post(APIConfiguration.teleBillPaymentUrl, body);
    return response.body;
  }
}
