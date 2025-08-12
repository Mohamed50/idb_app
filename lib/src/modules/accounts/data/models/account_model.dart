// To parse this JSON data, do
//
//     final accountModel = accountModelFromJson(jsonString);

import 'dart:convert';

import 'account_type_model.dart';

List<AccountModel> accountModelFromJson(List json, {String? name, String? phone}) => List<AccountModel>.from(json.map((x) => AccountModel.fromJson(x, name, phone)));

String accountModelToJson(List<AccountModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountModel {
  final bool isAllowToOwnTran;
  final String iban;
  final AccountType accountType;
  final bool isPrimary;
  final bool isAllowFromOwnTran;
  final String accountNo;
  final String currencyCode;
  final bool isAllowOthersTran;
  bool isLinked;
  final String? branchCode;
  String balance;
  String name;
  String phone;

  AccountModel({
    this.isAllowToOwnTran = false,
    this.iban = '',
    required this.accountType,
    this.isPrimary = false,
    this.isAllowFromOwnTran = false,
    required this.accountNo,
    this.currencyCode = 'SDG',
    this.isAllowOthersTran = false,
    this.isLinked = false,
    this.branchCode = '',
    this.balance = '0',
    this.name = '',
    this.phone = '',
  });

  factory AccountModel.fromJson(Map<String, dynamic> json, [String? name, String? phone]) => AccountModel(
    isAllowToOwnTran: json["Is_Allow_To_Own_Tran"] ?? false,
    iban: json["IBAN"],
    accountType: AccountTypeExtensions.fromCode(json["Account_Type_Code"])!,
    isPrimary: json["Is_Primary"] ?? false,
    isAllowFromOwnTran: json["Is_Allow_From_Own_Tran"] ?? false,
    accountNo: json["Account_No"],
    currencyCode: json["Currency_Code"] ?? 'SDG',
    isAllowOthersTran: json["Is_Allow_Others_Tran"] ?? false,
    isLinked: json['Is_Linked'] ?? true,
    branchCode: json["Branch_Code"],
    balance: json["Balance"] ?? '0',
    name: name ?? '',
    phone: phone ?? '',
  );

  Map<String, dynamic> toJson() => {
    "Is_Allow_To_Own_Tran": isAllowToOwnTran,
    "IBAN": iban,
    "Account_Type_Code": accountType.toCode(),
    "Is_Primary": isPrimary,
    "Is_Allow_From_Own_Tran": isAllowFromOwnTran,
    "Account_No": accountNo,
    "Currency_Code": currencyCode,
    "Is_Allow_Others_Tran": isAllowOthersTran,
    "Branch_Code": branchCode,
    "Custom_Name": name,
    "Is_Linked": isLinked,
  };

  String toCopiedContent() {
    return 'Account Number: $accountNo\nIBAN: $iban';
  }


  /// **Override equality operator to compare accounts by `accountNo`.**
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AccountModel &&
              runtimeType == other.runtimeType &&
              accountNo == other.accountNo;

  /// **Override hashCode to match `accountNo`.**
  @override
  int get hashCode => accountNo.hashCode;

}
