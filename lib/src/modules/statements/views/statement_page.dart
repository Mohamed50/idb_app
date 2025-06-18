import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/statements/controllers/statement_view_model.dart';
import 'package:az_banking_app/src/views/custom/custom_date_picker.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/statement_list_view.dart';

class StatementPage extends GetView<StatementViewModel> {
  const StatementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ColorManager.lightBackgroundColor,
        appBar: CustomAppbar(
          title: TranslationsKeys.tkStatementServiceLabel,
        ),
        body: ListView(
          padding: EdgeInsets.all(24.0),
          children: [
            Obx(
              () => CustomTabBar(
                labels: const [
                  TranslationsKeys.tkLast5Label,
                  TranslationsKeys.tkWeekLabel,
                  TranslationsKeys.tkMonthLabel,
                  TranslationsKeys.tkCustomLabel,
                ],
                onTap: controller.onFilterChanged,
                selectedIndex: controller.selectedTabIndex,
              ),
            ),
            SizedBox(height: 24.0),
            AccountsDropDown(
              onChanged: controller.onSelectedAccountChanged,
              fillColor: ColorManager.darkBackgroundColor,
              changePrimaryOnChange: true,
            ),
            SizedBox(height: 12.0),
            Obx(
              () => CustomVisible(
                show: controller.selectedTabIndex == 3,
                child: CustomDateRangeField(
                  dateTimeRange: controller.selectedDateTimeRange,
                  onChanged: controller.onDateRangeChanged,
                ),
              ),
            ),
            SizedBox(height: 12.0),
            CustomText.title(TranslationsKeys.tkTransactionsLabel),
            SizedBox(height: 12.0),
            Obx(
              () => ApiHandler(
                apiResponse: controller.statements,
                onFail: Center(child: CustomText(TranslationsKeys.tkNoDataLabel)),
                onSuccess: StatementsListView(statements: controller.statements.data ?? []),
              ),
            )
          ],
        ),
      ),
    );
  }
}
