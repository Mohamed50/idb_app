List<HistoryModel> historyModelFromJson(List json) => List<HistoryModel>.from(json.map((x) => HistoryModel.fromJson(x)));


class HistoryModel {
  final int responseCode;
  final String referenceNo;
  final String responseMessage;
  final String tranDateTime;
  final String? payCustomerCode;
  final DateTime tranDbDateTime;
  final String amount;
  final List<ToAccountInfo> toAccountInfo;
  final List<FromAccountInfo> fromAccountInfo;
  final String fees;
  final String billInfo;

  HistoryModel({
    required this.responseCode,
    required this.referenceNo,
    required this.responseMessage,
    required this.tranDateTime,
    required this.payCustomerCode,
    required this.tranDbDateTime,
    required this.amount,
    required this.toAccountInfo,
    required this.fromAccountInfo,
    required this.fees,
    required this.billInfo,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    responseCode: json["Response_Code"],
    referenceNo: json["Reference_No"],
    responseMessage: json["Response_Message"],
    tranDateTime: json["Tran_DateTime"],
    payCustomerCode: json["Pay_Customer_Code"],
    tranDbDateTime: DateTime.parse(json["Tran_DB_DateTime"]),
    amount: json["Amount"] ?? '0.0',
    toAccountInfo: List<ToAccountInfo>.from(json["To_Account_Info"].map((x) => ToAccountInfo.fromJson(x))),
    fromAccountInfo: List<FromAccountInfo>.from(json["From_Account_Info"].map((x) => FromAccountInfo.fromJson(x))),
    fees: json["Fees"] ?? '0.0',
    billInfo: json["Bill_Info"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "Response_Code": responseCode,
    "Reference_No": referenceNo,
    "Response_Message": responseMessage,
    "Tran_DateTime": tranDateTime,
    "Pay_Customer_Code": payCustomerCode,
    "Tran_DB_DateTime": tranDbDateTime.toIso8601String(),
    "Amount": amount,
    "To_Account_Info": List<dynamic>.from(toAccountInfo.map((x) => x.toJson())),
    "From_Account_Info": List<dynamic>.from(fromAccountInfo.map((x) => x.toJson())),
    "Fees": fees,
    "Bill_Info": billInfo,
  };
}

class FromAccountInfo {
  final String accountTypeCode;
  final String accountNo;
  final String currencyCode;
  final String branchCode;

  FromAccountInfo({
    required this.accountTypeCode,
    required this.accountNo,
    required this.currencyCode,
    required this.branchCode,
  });

  factory FromAccountInfo.fromJson(Map<String, dynamic> json) => FromAccountInfo(
    accountTypeCode: json["Account_Type_Code"],
    accountNo: json["Account_No"],
    currencyCode: json["Currency_Code"],
    branchCode: json["Branch_Code"],
  );

  Map<String, dynamic> toJson() => {
    "Account_Type_Code": accountTypeCode,
    "Account_No": accountNo,
    "Currency_Code": currencyCode,
    "Branch_Code": branchCode,
  };
}

class ToAccountInfo {
  ToAccountInfo();

  factory ToAccountInfo.fromJson(Map<String, dynamic> json) => ToAccountInfo(
  );

  Map<String, dynamic> toJson() => {
  };
}
