import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_type_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/service_config.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class TransferService extends ApiService {
  Future<Map<String, dynamic>> transferToDifferentBank(
    AccountModel fromAccount,
    String toAccountBPAN,
    String comment,
    double amount,
  ) async {
    final body = {
      'From_Account_Info': [fromAccount.toJson()],
      'To_Card': toAccountBPAN,
      'Amount': amount,
      'comment': comment,
    };
    final response = await transaction(APIConfiguration.transferBetweenAccountOutsideBankUrl, body, onDuplicated: onDuplicated);
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
    final response = await transaction(APIConfiguration.transferBetweenAccountInsideBankUrl, body, onDuplicated: onDuplicated);
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
    final response = await transaction(APIConfiguration.transferBetweenMyOwnAccountUrl, body, onDuplicated: onDuplicated);
    return response.body;
  }

  Future<AccountModel> fetchAccountInfoInsideBank(String accountNumber, String accountTypeCode) async {
    final body = {
      "Cust_Info_Type": 2,
      "To_Account_Info": [
        {
          "Account_No": accountNumber,
          "Account_Type_Code": accountTypeCode,
          "Currency_Code": '',
          "Branch_code": '',
        }
      ],
      "RIM": "",
      "Comment": '',
      "Tran_DateTime": DateTime.now().millisecondsSinceEpoch.toString(),
    };
    final response = await post(APIConfiguration.fetchAccountInfoInsideBankUrl, body);
    return accountModelFromJson(response.body['Accounts_List'],
            name: response.body['Customer_Name'], phone: response.body['Phone_No'])
        .first;
  }

  Future<AccountModel> fetchAccountInfoOutsideBank(String accountNumber) async {
    final body = {
      "PAN": accountNumber,
      "uuid": const Uuid().v4(),
      "tranDateTime": DateFormat('dd-MM-yy-hh-mm-ss', "en").format(DateTime.now()).replaceAll('-', ''),
      "applicationId": 'com.edb.infinity',
    };
    final response = await post(APIConfiguration.fetchAccountInfoOutsideBankUrl, body);
    return AccountModel(
        accountType: AccountType.ntd,
        accountNo: response.body['PAN'],
        name: response.body['customerName'],
        iban: response.body['BBAN']);
  }
}
