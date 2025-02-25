List<ExchangeRateModel> exchangeRateModelFromJson(List json) => List<ExchangeRateModel>.from(json.map((x) => ExchangeRateModel.fromJson(x)));


class ExchangeRateModel {
  final String currencyNameAr;
  final String currencyNameEn;
  final String currencySymbolEn;
  final String currencySymbolAr;
  final String currencySellRate;
  final String currencyPurchRate;
  final String currencyAvgRate;

  ExchangeRateModel({
    required this.currencyNameAr,
    required this.currencyNameEn,
    required this.currencySymbolEn,
    required this.currencySymbolAr,
    required this.currencySellRate,
    required this.currencyPurchRate,
    required this.currencyAvgRate,
  });

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) => ExchangeRateModel(
    currencyNameAr: json["Currency_Name_AR"],
    currencyNameEn: json["Currency_Name_EN"],
    currencySymbolEn: json["Currency_Symbol_EN"],
    currencySymbolAr: json["Currency_Symbol_AR"],
    currencySellRate: double.parse(json["Currency_Sell_Rate"] ?? '0').toString(),
    currencyPurchRate: double.parse(json["Currency_Purch_Rate"] ?? '0').toString(),
    currencyAvgRate: double.parse(json["Currency_Avg_Rate"] ?? '0').toString(),
  );

  Map<String, dynamic> toJson() => {
    "Currency_Name_AR": currencyNameAr,
    "Currency_Name_EN": currencyNameEn,
    "Currency_Symbol_EN": currencySymbolEn,
    "Currency_Symbol_AR": currencySymbolAr,
    "Currency_Sell_Rate": currencySellRate,
    "Currency_Purch_Rate": currencyPurchRate,
    "Currency_Avg_Rate": currencyAvgRate,
  };
}
