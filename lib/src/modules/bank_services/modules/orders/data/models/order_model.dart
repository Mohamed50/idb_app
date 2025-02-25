import 'package:az_banking_app/src/config/config.dart';

List<OrderModel> orderModelFromJson(List json) => List<OrderModel>.from(json.map((x) => OrderModel.fromJson(x)));


class OrderModel {
  final String name;
  final String requestCode;
  final DateTime tranDateTime;
  final String requestStatus;
  final String comment;

  OrderModel({
    required this.name,
    required this.requestCode,
    required this.tranDateTime,
    required this.requestStatus,
    required this.comment,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    name: _getRequestCodeName(json["Request_Code"]),
    requestCode: json["Request_Code"],
    tranDateTime: DateTime.parse(json["Tran_DateTime"]),
    requestStatus: json["Request_Status"],
    comment: json["Comment"],
  );

  Map<String, dynamic> toJson() => {
    "Comment": comment,
    "Tran_DateTime": tranDateTime.toIso8601String(),
    "Request_Status": requestStatus,
    "Request_Code": requestCode,
  };

  static String _getRequestCodeName(String code) {
    if (code == '2001') return 'New credit card';
    if (code == '2002') return 'Replacement credit card';
    if (code == '1002') return TranslationsKeys.tk25PagesChequeBookLabel;
    if (code == '1001') return TranslationsKeys.tk50PagesChequeBookLabel;
    return 'unknown';
  }
}
