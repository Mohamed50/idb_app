import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/essentials/services/memory_service.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';

class AccountService extends ApiService {
  // fetch user accounts.
  Future<List<AccountModel>> fetchUserAccounts() async {
    if(accessToken != null) {
      final response = await get(
        APIConfiguration.userAccountsUrl,
      );
      return accountModelFromJson(response.body['Accounts_List']);
    }
    return <AccountModel>[];
  }

  Future<bool> linkAccounts(String userId, List<AccountModel> selectedAccounts) async {
    MemoryService.instance.userId = userId;
    Map<String, dynamic> body = {'User_ID': userId, 'Accounts_List': selectedAccounts.map((e) => e.toJson()).toList()};
    await post(APIConfiguration.linkAccountsUrl, body);
    return true;
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

  Future<List<AccountModel>> getAvailableAccounts(String userId) async {
    Map<String, dynamic> body = {'User_ID': userId};
    final response = await post(APIConfiguration.getAvailableAccounts, body);
    return accountModelFromJson(response.body['Accounts_List']);
  }
}
