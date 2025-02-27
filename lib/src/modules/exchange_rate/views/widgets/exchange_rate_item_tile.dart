import 'package:az_banking_app/src/config/config.dart';
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
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.subtitle(
                TranslationsKeys.tkCurrencyLabel,
                fontSize: 12.0,
              ),
              CustomText.title(
                exchangeRateModel.currencyNameEn,
                fontSize: 14.0,
              ),
            ],
          ),
          Divider(height: 24.0, thickness: 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.subtitle(
                    TranslationsKeys.tkBuyLabel,
                    fontSize: 12.0,
                  ),
                  CustomText.title(
                    exchangeRateModel.currencyPurchRate,
                    fontSize: 14.0,
                  ),
                  SizedBox(height: 12.0),
                  CustomText.subtitle(
                    TranslationsKeys.tkSellLabel,
                    fontSize: 12.0,
                  ),
                  CustomText.title(
                    exchangeRateModel.currencySellRate,
                    fontSize: 14.0,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.subtitle(
                    TranslationsKeys.tkAverageLabel,
                    fontSize: 12.0,
                  ),
                  CustomText.title(
                    exchangeRateModel.currencyPurchRate,
                    fontSize: 24,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
