import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/data/models/order_model.dart';
import 'package:az_banking_app/src/modules/branches/data/models/branch_model.dart';

class OrderService extends ApiService {
  Future<List<OrderModel>> fetchOrderStatus() async {
    final body = {};
    final response = await post(APIConfiguration.trackOrderStatusUrl, body);
    return orderModelFromJson(response.body['Requests_List']);
  }

  Future<Map<String, dynamic>> fetchChequeStatus(AccountModel fromAccount, String chequeNumber) async {
    final body = {...fromAccount.toJson(), 'Cheque_No': chequeNumber};
    final response = await post(APIConfiguration.trackChequeStatusUrl, body);
    return response.body;
  }

  Future<Map<String, dynamic>> requestChequeBook(AccountModel fromAccount, BranchModel branchModel, String numberOfPages,) async {
    final body = {
      'From_Account_Info': [fromAccount.toJson()],
      'From_Branch': [branchModel.toJson()],
      'Request_Code': numberOfPages,
      "Pick_From":branchModel.code,
      "Comment" : "",
    };
    final response = await post(APIConfiguration.requestChequeBookUrl, body);
    return response.body;
  }
}
