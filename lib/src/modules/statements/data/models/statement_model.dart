

List<StatementModel> statementModelFromJson(List json) => List<StatementModel>.from(json.map((x) => StatementModel.fromJson(x)));

enum TransactionDirection {tranIn, tranOut}
class StatementModel {
  final DateTime tranDateTime;
  final String amount;
  final String naration;
  final TransactionDirection tranDirection;

  StatementModel({
    required this.tranDateTime,
    required this.amount,
    required this.naration,
    required this.tranDirection,
  });

  factory StatementModel.fromJson(Map<String, dynamic> json) => StatementModel(
    tranDateTime: DateTime.parse(json["Tran_DateTime"]),
    amount: json["Amount"],
    naration: json["Naration"],
    tranDirection: json["Tran_Direction"] == 'D' ? TransactionDirection.tranOut : TransactionDirection.tranIn,
  );

  Map<String, dynamic> toJson() => {
    "Tran_DateTime": "${tranDateTime.year.toString().padLeft(4, '0')}-${tranDateTime.month.toString().padLeft(2, '0')}-${tranDateTime.day.toString().padLeft(2, '0')}",
    "Amount": amount,
    "Naration": naration,
    "Tran_Direction": tranDirection,
  };
}
