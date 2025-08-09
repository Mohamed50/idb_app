import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/statements/controllers/history_view_model.dart';
import 'package:az_banking_app/src/modules/statements/data/models/service_model.dart';
import 'package:az_banking_app/src/modules/statements/views/widgets/history_list_view.dart';
import 'package:az_banking_app/src/views/custom/custom_drop_down.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPage extends GetView<HistoryViewModel> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightBackgroundColor,
      appBar: CustomAppbar(
        title: TranslationsKeys.tkHistoryServiceLabel,
      ),
      body: ListView(
        padding: EdgeInsets.all(24.0),
        children: [
          SizedBox(height: 24.0),
          AccountsDropDown(
            onChanged: controller.onSelectedAccountChanged,
            fillColor: ColorManager.darkBackgroundColor,
            changePrimaryOnChange: true,
          ),
          SizedBox(height: 12.0),
          Obx(
            () => ApiHandler(
              apiResponse: controller.services,
              onFail: Container(),
              onSuccess: CustomDropDown<ServiceModel>(
                label: TranslationsKeys.tkServicesLabel,
                options: controller.services.data ?? [],
                onChanged: controller.onServiceChanged,
              ),
            ),
          ),
          SizedBox(height: 12.0),
          CustomText.title(TranslationsKeys.tkTransactionsLabel),
          SizedBox(height: 12.0),
          Obx(
            () => ApiHandler(
              apiResponse: controller.history,
              onFail: Center(child: CustomText(TranslationsKeys.tkNoDataLabel)),
              onSuccess: HistoryListView(items: controller.history.data ?? []),
            ),
          )
        ],
      ),
    );
  }
}
