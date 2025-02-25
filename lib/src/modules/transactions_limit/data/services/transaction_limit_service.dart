import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/transactions_limit/data/models/transaction_limit_model.dart';

class TransactionsLimitService extends ApiService{

  Future<TransactionsLimitModel> fetchTransactionsLimit() async{
    final response = await get(APIConfiguration.fetchTransactionsLimitUrl);
    return TransactionsLimitModel.fromJson(response.body);
  }

}