import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/exchange_rate/data/models/exchange_rate_model.dart';
import 'package:az_banking_app/src/modules/exchange_rate/views/widgets/exchange_rate_item_tile.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';

class ExchangeRatesListView extends StatelessWidget {
  final List<ExchangeRateModel> rates;

  const ExchangeRatesListView({super.key, required this.rates});

  @override
  Widget build(BuildContext context) {
    if (rates.isNotEmpty) {
      return ListView.separated(
        padding: EdgeInsets.all(24.0),
        itemCount: rates.length,
        itemBuilder: (context, index) => ExchangeRateItemTile(exchangeRateModel: rates[index]),
        separatorBuilder: (context, index) => SizedBox(height: 12.0),
      );
    }
    return Center(child: CustomText(TranslationsKeys.tkNoDataLabel));
  }
}
