import 'dart:convert';

import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/service_config.dart';

class TransferService extends ApiService {
  Future<Map<String, dynamic>> transferToDifferentBank(
    AccountModel fromAccount,
    String toAccountBPAN,
    String comment,
    double amount,
  ) async {
    final body = {
      'From_Account_Info': [fromAccount.toJson()],
      'To_Account': toAccountBPAN,
      'Amount': amount,
      'comment': comment,
    };
    final response = await post(APIConfiguration.transferBetweenAccountOutsideBankUrl, body);
    return response.body;
  }

  Future<Map<String, dynamic>> transferToAccountInsideTheBank(
    AccountModel fromAccount,
    AccountModel toAccount,
    String phone,
    String comment,
    double amount,
  ) async {
    final body = {
      'From_Account_Info': [fromAccount.toJson()],
      'To_Account_Info': [toAccount.toJson()],
      'Customer_Name': user?.customerName,
      'Amount': amount,
      'Phone_No': phone,
      'comment': comment,
      'Service_Code': ServicesConfiguration.transferBetweenAccountsServiceCode,
    };
    final response = await post(APIConfiguration.transferBetweenAccountInsideBankUrl, body);
    return response.body;
  }

  Future<Map<String, dynamic>> transferBetweenMyAccounts(
    AccountModel fromAccount,
    AccountModel toAccount,
    String phone,
    String comment,
    double amount,
  ) async {
    final body = {
      'From_Account_Info': [fromAccount.toJson()],
      'To_Account_Info': [toAccount.toJson()],
      'Customer_Name': user?.customerName,
      'Amount': amount,
      'Phone_No': phone,
      'comment': comment,
      'Service_Code': ServicesConfiguration.transferBetweenAccountsServiceCode,
    };
    final response = await post(APIConfiguration.transferBetweenMyOwnAccountUrl, body);
    return response.body;
  }

}
