// To parse this JSON data, do
//
//     final transactionsLimitModel = transactionsLimitModelFromJson(jsonString);

import 'dart:convert';

TransactionsLimitModel transactionsLimitModelFromJson(String str) => TransactionsLimitModel.fromJson(json.decode(str));

String transactionsLimitModelToJson(TransactionsLimitModel data) => json.encode(data.toJson());

class TransactionsLimitModel {
  final List<LimitModel> limitsList;
  final List<FeeModel> feesList;

  TransactionsLimitModel({
    required this.limitsList,
    required this.feesList,
  });

  factory TransactionsLimitModel.fromJson(Map<String, dynamic> json) => TransactionsLimitModel(
    limitsList: List<LimitModel>.from(json["Limits_List"].map((x) => LimitModel.fromJson(x))),
    feesList: List<FeeModel>.from(json["Fees_List"].map((x) => FeeModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Limits_List": List<dynamic>.from(limitsList.map((x) => x.toJson())),
    "Fees_List": List<dynamic>.from(feesList.map((x) => x.toJson())),
  };
}

class FeeModel {
  final int minTranAmount;
  final String serviceName;
  final String maxTranAmount;
  final String fees;

  FeeModel({
    required this.minTranAmount,
    required this.serviceName,
    required this.maxTranAmount,
    required this.fees,
  });

  factory FeeModel.fromJson(Map<String, dynamic> json) => FeeModel(
    minTranAmount: json["Min_Tran_Amount"],
    serviceName: json["Service_Name"],
    maxTranAmount: json["Max_Tran_Amount"],
    fees: json["Fees"],
  );

  Map<String, dynamic> toJson() => {
    "Min_Tran_Amount": minTranAmount,
    "Service_Name": serviceName,
    "Max_Tran_Amount": maxTranAmount,
    "Fees": fees,
  };
}

class LimitModel {
  final int amountPerTran;
  final String serviceName;
  final int amountPerDay;
  final int noOfTrans;

  LimitModel({
    required this.amountPerTran,
    required this.serviceName,
    required this.amountPerDay,
    required this.noOfTrans,
  });

  factory LimitModel.fromJson(Map<String, dynamic> json) => LimitModel(
    amountPerTran: json["Amount_Per_Tran"],
    serviceName: json["Service_Name"],
    amountPerDay: json["Amount_Per_Day"],
    noOfTrans: json["No_Of_Trans"],
  );

  Map<String, dynamic> toJson() => {
    "Amount_Per_Tran": amountPerTran,
    "Service_Name": serviceName,
    "Amount_Per_Day": amountPerDay,
    "No_Of_Trans": noOfTrans,
  };
}
