import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/transactions_limit/data/models/transaction_limit_model.dart';
import 'package:az_banking_app/src/modules/transactions_limit/data/services/transaction_limit_service.dart';
import 'package:get/get.dart';

class TransactionsLimitViewModel extends GetxController {
  final TransactionsLimitService _transactionsLimitService;

  final Rx<ApiResponse<TransactionsLimitModel>> _transactionsLimits = ApiResponse<TransactionsLimitModel>.idle().obs;

  ApiResponse<TransactionsLimitModel> get transactionsLimits => _transactionsLimits.value;

  TransactionsLimitViewModel(this._transactionsLimitService) {
    _initialize();
  }

  void _initialize() {
    _fetchTransactionsLimit();
  }

  void _fetchTransactionsLimit() {
    apiFetch(_transactionsLimitService.fetchTransactionsLimit()).listen((value) => _transactionsLimits.value = value);
  }
}
