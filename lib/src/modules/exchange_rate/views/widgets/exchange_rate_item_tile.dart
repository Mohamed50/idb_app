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
      color: ColorManager.darkBackgroundColor,
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTranslatedText(
                    textEn: exchangeRateModel.currencyNameEn,
                    textAr: exchangeRateModel.currencyNameAr,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomTranslatedText(
                    textEn: exchangeRateModel.currencySymbolEn,
                    textAr: exchangeRateModel.currencySymbolAr,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
          Divider(
            height: 24.0,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomText.subtitle(
                    TranslationsKeys.tkBuyLabel,
                    fontSize: 14.0,
                  ),
                  CustomText.title(
                    exchangeRateModel.currencyPurchRate,
                    fontSize: 14.0,
                  ),
                ],
              ),
              Column(
                children: [
                  CustomText.subtitle(
                    TranslationsKeys.tkSellLabel,
                    fontSize: 14.0,
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
                    fontSize: 14.0,
                  ),
                  CustomText.title(
                    exchangeRateModel.currencyPurchRate,
                    fontSize: 14,
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
