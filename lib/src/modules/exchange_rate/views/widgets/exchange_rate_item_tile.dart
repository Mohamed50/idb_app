import 'package:az_banking_app/src/config/colors.dart';
import 'package:az_banking_app/src/modules/exchange_rate/data/models/exchange_rate_model.dart';
import 'package:az_banking_app/src/views/custom/custom_container.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';

class ExchangeRateItemTile extends StatelessWidget {
  final ExchangeRateModel exchangeRateModel;

  const ExchangeRateItemTile({super.key, required this.exchangeRateModel});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: ColorManager.primaryColor.withValues(alpha: 0.08),
      padding: EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomCard(
              color: ColorManager.lightBackgroundColor,
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: CustomTranslatedText(
                textEn: exchangeRateModel.currencySymbolEn,
                textAr: exchangeRateModel.currencySymbolAr,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: ColorManager.primaryColor,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.subtitle(
                'Avg',
              ),
              CustomText.title(
                exchangeRateModel.currencyPurchRate,
                color: ColorManager.primaryColor,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.subtitle(
                'Buy',
              ),
              CustomText.title(
                exchangeRateModel.currencyPurchRate,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.subtitle(
                'Sell',
              ),
              CustomText.title(
                exchangeRateModel.currencySellRate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
