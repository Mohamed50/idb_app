import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';

class AccountService extends ApiService {
  // fetch user accounts.
  Future<List<AccountModel>> fetchUserAccounts() async {
    final response = await get(APIConfiguration.userAccountsUrl);
    return accountModelFromJson(response.body['Accounts_List']);
  }

  // fetch user accounts.
  Future<List<AccountModel>> mockUserAccounts() async {
    await Future.delayed(Duration(milliseconds: 300));
    return accountModelFromJson([
      {
        "Is_Allow_To_Own_Tran": true,
        "IBAN": "SD12345678901234567890",
        "Account_Type_Code": "CUR",
        "Is_Primary": true,
        "Is_Allow_From_Own_Tran": true,
        "Account_No": "100012345678",
        "Currency_Code": "SDG",
        "Is_Allow_Others_Tran": false,
        "Branch_Code": "001",
        "Balance": "150672.75"
      },
      {
        "Is_Allow_To_Own_Tran": false,
        "IBAN": "SD09876543210987654321",
        "Account_Type_Code": "SAV",
        "Is_Primary": false,
        "Is_Allow_From_Own_Tran": true,
        "Account_No": "200098765432",
        "Currency_Code": "USD",
        "Is_Allow_Others_Tran": true,
        "Branch_Code": "002",
        "Balance": "2330.50"
      },
      {
        "Is_Allow_To_Own_Tran": true,
        "IBAN": "SD11223344556677889900",
        "Account_Type_Code": "NTD",
        "Is_Primary": false,
        "Is_Allow_From_Own_Tran": false,
        "Account_No": "300011223344",
        "Currency_Code": "EUR",
        "Is_Allow_Others_Tran": false,
        "Branch_Code": "003",
        "Balance": "1950.00"
      }
    ]);
  }

  Future<List<AccountModel>> fetchBalance(List<AccountModel> accounts) async {
    final body = {'lang': '0', 'Accounts_List': accounts.map((e) => e.toJson()).toList()};
    List balances = [];
    try {
      final response = await post(APIConfiguration.balanceUrl, body);
      balances = response.body['Balance_List'];
    } catch (e) {
      balances = [];
    } finally {
      for (int i = 0; i < balances.length; i++) {
        accounts[i].balance = balances[i]['Balance'];
      }
    }
    return accounts;
  }
}
