import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/statements/data/models/statement_model.dart';
import 'package:az_banking_app/src/modules/statements/data/services/statement_service.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatementViewModel extends GetxController {
  final StatementService _statementService;

  final Rx<ApiResponse<List<StatementModel>>> _statements = ApiResponse<List<StatementModel>>.idle().obs;

  ApiResponse<List<StatementModel>> get statements => _statements.value;

  AccountModel? _selectedAccount;

  StatementViewModel(this._statementService);

  final RxInt _selectedTapIndex = 0.obs;
  int get selectedTabIndex => _selectedTapIndex.value;

  final Rx<DateTimeRange> _selectedDateTimeRange = Utils.getDateRangeFromDaysBack(7).obs;
  DateTimeRange get selectedDateTimeRange => _selectedDateTimeRange.value;

  void fetchStatement() {
    if(selectedTabIndex == 0) {
      apiFetch(_statementService.fetchLast5transactions(_selectedAccount!)).listen((value) => _statements.value = value);
    }
    else{
      apiFetch(_statementService.fetchStatementByDate(_selectedAccount!, selectedDateTimeRange)).listen((value) => _statements.value = value);
    }
  }

  void onSelectedAccountChanged(AccountModel value) {
    _selectedAccount = value;
    fetchStatement();
  }

  void accountChangeOnHomeNotifier(AccountModel value) {
    _selectedAccount = value;
    onFilterChanged(0);
  }

  void onFilterChanged(int value) {
    _selectedTapIndex.value = value;
    switch(value){
      case 0:
        fetchStatement();
        break;
      case 1:
        _selectedDateTimeRange.value = Utils.getDateRangeFromDaysBack(7);
        fetchStatement();
        break;
      case 2:
        _selectedDateTimeRange.value = Utils.getDateRangeFromDaysBack(30);
        fetchStatement();
        break;
    }
  }

  void onDateRangeChanged(DateTimeRange value) {
    _selectedDateTimeRange.value = value;
    fetchStatement();
  }
}
