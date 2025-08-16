import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';

class BillsService extends ApiService {


  Future<Map<String, dynamic>> billInquiry(String billerId, AccountModel fromAccount, String billNumber, double? amount,
      [String? secondaryNumber]) async {
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

  Future<Map<String, dynamic>> billPayment(String billerId, AccountModel fromAccount, String billNumber, double amount,
      [String? secondaryNumber]) async {
    final body = {
      'Biller_ID': billerId,
      'Pay_Customer_Code': billNumber,
      'Additional_Reference': secondaryNumber ?? '',
      'Amount': amount,
      'Account_Info': fromAccount.toJson()
    };
    final response = await transaction(APIConfiguration.teleBillPaymentUrl, body, onDuplicated: onDuplicated);
    return response.body;
  }


  Future<Map<String, dynamic>> mockBillInquiry(String billerId, AccountModel fromAccount, String billNumber, double? amount,
      [String? secondaryNumber]) async {
    final body = {
      'Biller_ID': billerId,
      'Pay_Customer_Code': billNumber,
      'Additional_Reference': secondaryNumber ?? '',
      'Amount': amount ?? '',
      'Account_Info': fromAccount.toJson(),
      'Pay_Flag': 0,
    };
    final response = await post(APIConfiguration.mockBillPaymentUrl, body);
    return response.body;
  }

  Future<Map<String, dynamic>> mockBillPayment(String billerId, AccountModel fromAccount, String billNumber, double amount,
      [String? secondaryNumber]) async {
    final body = {
      'Biller_ID': billerId,
      'Pay_Customer_Code': billNumber,
      'Amount': amount,
      'Account_Info': fromAccount.toJson(),
      'Pay_Flag': 1,
    };
    if (secondaryNumber != null) {
      body['Additional_Reference'] = secondaryNumber;
    }
    final response = await transaction(APIConfiguration.mockBillPaymentUrl, body, onDuplicated: onDuplicated);
    return response.
    body;
  }


}
