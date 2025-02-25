import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/service_config.dart';

class TeleBillsService extends ApiService {
  Future<Map<String, dynamic>> topUpZain(AccountModel fromAccount, String phoneNumber, double amount) async {
    return await _topUp(ServicesConfiguration.topUpZainServiceCode, fromAccount, phoneNumber, amount);
  }

  Future<Map<String, dynamic>> topUpMtn(AccountModel fromAccount, String phoneNumber, double amount) async {
    return await _topUp(ServicesConfiguration.topUpMtnServiceCode, fromAccount, phoneNumber, amount);
  }

  Future<Map<String, dynamic>> topUpSudani(AccountModel fromAccount, String phoneNumber, double amount) async {
    return await _topUp(ServicesConfiguration.topUpSudaniServiceCode, fromAccount, phoneNumber, amount);
  }

  Future<Map<String, dynamic>> billInquiryZain(AccountModel fromAccount, String phoneNumber) async {
    return await _billInquiry(ServicesConfiguration.billInquiryZainServiceCode, fromAccount, phoneNumber);
  }

  Future<Map<String, dynamic>> billInquiryMtn(AccountModel fromAccount, String phoneNumber) async {
    return await _billInquiry(ServicesConfiguration.billInquiryMtnServiceCode, fromAccount, phoneNumber);
  }

  Future<Map<String, dynamic>> billInquirySudani(AccountModel fromAccount, String phoneNumber) async {
    return await _billInquiry(ServicesConfiguration.billInquirySudaniServiceCode, fromAccount, phoneNumber);
  }

  Future<Map<String, dynamic>> billPaymentZain(AccountModel fromAccount, String phoneNumber, double amount) async {
    return await _billPayment(ServicesConfiguration.billPaymentZainServiceCode, fromAccount, phoneNumber, amount);
  }

  Future<Map<String, dynamic>> billPaymentMtn(AccountModel fromAccount, String phoneNumber, double amount) async {
    return await _billPayment(ServicesConfiguration.billPaymentMtnServiceCode, fromAccount, phoneNumber, amount);
  }

  Future<Map<String, dynamic>> billPaymentSudani(AccountModel fromAccount, String phoneNumber, double amount) async {
    return await _billPayment(ServicesConfiguration.billPaymentSudaniServiceCode, fromAccount, phoneNumber, amount);
  }

  Future<Map<String, dynamic>> _topUp(String billerId, AccountModel fromAccount, String phoneNumber, double amount) async {
    final body = {
      'Biller_ID': billerId,
      'Pay_Customer_Code': phoneNumber,
      'Amount': amount,
      'Account_Info': fromAccount.toJson()
    };
    final response = await post(APIConfiguration.teleTopUpUrl, body);
    return response.body;
  }

  Future<Map<String, dynamic>> _billInquiry(String billerId, AccountModel fromAccount, String phoneNumber) async {
    final body = {
      'Biller_ID': billerId,
      'Pay_Customer_Code': phoneNumber,
      'Additional_Reference': '',
      'Amount': '',
      'Account_Info': fromAccount.toJson()
    };
    final response = await post(APIConfiguration.teleBillInquiryUrl, body);
    return response.body;
  }

  Future<Map<String, dynamic>> _billPayment(String billerId, AccountModel fromAccount, String phoneNumber, double amount) async {
    final body = {
      'Biller_ID': billerId,
      'Pay_Customer_Code': phoneNumber,
      'Amount': amount,
      'Account_Info': fromAccount.toJson()
    };
    final response = await post(APIConfiguration.teleBillPaymentUrl, body);
    return response.body;
  }
}
