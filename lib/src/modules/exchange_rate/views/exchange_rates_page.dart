import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/exchange_rate/controllers/exchange_rate_view_model.dart';
import 'package:az_banking_app/src/views/custom/api_handler.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/exchange_rates_list_view.dart';

class ExchangeRatesPage extends GetView<ExchangeRateViewModel> {
  const ExchangeRatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightBackgroundColor,
      appBar: CustomAppbar(title: TranslationsKeys.tkViewExchangeRateServiceLabel,),
      body: Obx(
        () => ApiHandler(
          apiResponse: controller.exchangeRates,
          onSuccess: ExchangeRatesListView(rates: controller.exchangeRates.data ?? []),
        ),
      ),
    );
  }
}
