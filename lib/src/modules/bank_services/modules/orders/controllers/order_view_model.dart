import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/data/models/order_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/data/models/pages_number_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/data/services/order_service.dart';
import 'package:az_banking_app/src/modules/branches/data/models/branch_model.dart';
import 'package:get/get.dart';

class OrderViewModel extends GetxController {
  final OrderService _orderService;

  OrderViewModel(this._orderService){
    _initialize();
  }

  AccountModel? _fromAccount;
  BranchModel? _receivingBranch;
  String? _chequeNumber, _pagesNumber;
  
  final Rx<ApiResponse<List<OrderModel>>> _orders = ApiResponse<List<OrderModel>>.idle().obs;
  ApiResponse<List<OrderModel>> get orders => _orders.value;
  
  
  void _initialize(){
    _fetchOrderStatus();
  }

  Future _fetchOrderStatus() async {
    apiFetch(_orderService.fetchOrderStatus()).listen((value) => _orders.value = value);
  }

  Future<Map<String, dynamic>> fetchChequeStatus() async {
    return await _orderService.fetchChequeStatus(_fromAccount!, _chequeNumber!);
  }

  Future<Map<String, dynamic>> requestChequeBook() async {
    return await _orderService.requestChequeBook(_fromAccount!, _receivingBranch!, _pagesNumber!);
  }

  void onFromAccountChanged(AccountModel? value) {
    _fromAccount = value;
  }

  void onChequeNumberChanged(String? value) {
    _chequeNumber = value;
  }

  void onPagesNumberChanged(PagesNumberModel? value) {
    _pagesNumber = value?.code.toString();
  }

  void onReceivingBranchChanged(BranchModel? value) {
    _receivingBranch = value;
  }
}
