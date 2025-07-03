import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/statements/data/models/statement_model.dart';
import 'package:az_banking_app/src/modules/statements/data/services/statement_service.dart';
import 'package:get/get.dart';

class HistoryViewModel extends GetxController {
  final StatementService _statementService;

  final Rx<ApiResponse<List<StatementModel>>> _statements = ApiResponse<List<StatementModel>>.idle().obs;

  ApiResponse<List<StatementModel>> get statements => _statements.value;

  AccountModel? _selectedAccount;

  HistoryViewModel(this._statementService);

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() {
    apiFetch(_statementService.fetchHistoryByDate()).listen((value) => _statements.value = value);
  }

  void onSelectedAccountChanged(AccountModel value) {
    _selectedAccount = value;
    fetchData();
  }
}
