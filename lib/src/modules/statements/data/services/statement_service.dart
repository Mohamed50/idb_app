import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/statements/data/models/statement_model.dart';
import 'package:az_banking_app/src/utils/get_utils.dart';
import 'package:flutter/material.dart';

class StatementService extends ApiService {
  Future<List<StatementModel>> fetchLast5transactions(AccountModel accountModel) async {
    return await _fetchStatement(accountModel, DateTime.now(), DateTime.now(), false, false);
  }

  Future<List<StatementModel>> fetchStatementByDate(AccountModel accountModel, DateTimeRange dateTimeRange) async {
    return await _fetchStatement(accountModel, dateTimeRange.start, dateTimeRange.end, false, true);
  }

  Future<List<StatementModel>> _fetchStatement(
    AccountModel accountModel,
    DateTime fromDate,
    DateTime toDate,
    bool isDownloadable,
    bool isPeriodic,
  ) async {
    final body = {
      "Account_No": accountModel.accountNo,
      "Is_Period": isPeriodic ? 1 : 0,
      "Is_Downloadable": isDownloadable ? 1 : 0,
      "From_Date": Utils.formatDateToAzDateTime(fromDate),
      "To_Date": Utils.formatDateToAzDateTime(toDate)
    };
    final response = await post(APIConfiguration.fetchStatementUrl, body);
    return statementModelFromJson(response.body['Statement_List']);
  }
}
