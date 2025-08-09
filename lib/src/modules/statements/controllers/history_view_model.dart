import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/statements/data/models/history_model.dart';
import 'package:az_banking_app/src/modules/statements/data/services/statement_service.dart';
import 'package:get/get.dart';
import '../data/models/service_model.dart';

class HistoryViewModel extends GetxController {
  final StatementService _statementService;

  final Rx<ApiResponse<List<HistoryModel>>> _history = ApiResponse<List<HistoryModel>>.idle().obs;

  ApiResponse<List<HistoryModel>> get history => _history.value;

  final Rx<ApiResponse<List<ServiceModel>>> _services = ApiResponse<List<ServiceModel>>.idle().obs;

  ApiResponse<List<ServiceModel>> get services => _services.value;

  AccountModel? _selectedAccount;

  ServiceModel? _selectedService;

  HistoryViewModel(this._statementService);

  @override
  void onInit() {
    fetchData();
    fetchServices();
    super.onInit();
  }

  void fetchData() {
    apiFetch(_statementService.fetchHistoryByDate(_selectedService?.serviceCode ?? '0000')).listen((value) => _history.value = value);
  }

  void fetchServices() {
    apiFetch(_statementService.fetchServiceList()).listen((value) => _services.value = value);
  }

  void onSelectedAccountChanged(AccountModel value) {
    _selectedAccount = value;
    fetchData();
  }

  void onServiceChanged(ServiceModel? value) {
    _selectedService = value;
    fetchData();
  }
}
