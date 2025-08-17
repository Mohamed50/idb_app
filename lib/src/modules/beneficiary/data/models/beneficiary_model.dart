import 'dart:convert';

import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/tele_provider_enum.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/tele_service_type.dart';
import 'package:get/get.dart';

/// **Enum representing different beneficiary types**
enum BeneficiaryType { electricity, telecommunication, inside, outside }

/// **Model class for a Beneficiary**
class BeneficiaryModel {
  int id;
  String number;
  String name;
  TeleProvider? provider;
  TeleServiceType? serviceType;
  BeneficiaryType type;

  BeneficiaryModel({this.id = -1,required this.number, required this.name, required this.type, this.provider, this.serviceType});

  /// **Convert BeneficiaryModel to JSON**
  Map<String, dynamic> toJson() {
    return {
      "number": number,
      "name": name,
      "type": type.toString().split('.').last, // Convert Enum to String
      "provider": provider.toString().split('.').last, // Convert Enum to String
      "service_type": serviceType.toString().split('.').last, // Convert Enum to String
    };
  }

  /// **Create BeneficiaryModel from JSON**
  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    return BeneficiaryModel(
      number: json["number"],
      name: json["name"],
      type: BeneficiaryType.values.firstWhere((e) => e.toString().split('.').last == json["type"]),
      provider: TeleProvider.values.firstWhereOrNull((e) => e.toString().split('.').last == json["provider"]),
      serviceType: TeleServiceType.values.firstWhereOrNull((e) => e.toString().split('.').last == json["service_type"]),
    );
  }

  @override
  String toString() {
    return '$name - ($number)';
  }

  /// **Override equality operator to compare accounts by `accountNo`.**
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BeneficiaryModel && runtimeType == other.runtimeType && number == other.number;

  /// **Override hashCode to match `number`.**
  @override
  int get hashCode => number.hashCode;
}

/// **Convert List of BeneficiaryModel to JSON String**
String beneficiaryListToJson(List<BeneficiaryModel> beneficiaries) {
  List<Map<String, dynamic>> jsonList = beneficiaries.map((b) => b.toJson()).toList();
  return jsonEncode(jsonList);
}

/// **Convert JSON String to List of BeneficiaryModel**
List<BeneficiaryModel> beneficiaryListFromJson(String jsonString) {
  List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.map((b) => BeneficiaryModel.fromJson(b)).toList();
}

extension BeneficiaryTypeExtension on BeneficiaryType {
  /// **Returns an Icon based on BeneficiaryType**
  String toIcon() {
    switch (this) {
      case BeneficiaryType.electricity:
        return AssetsManager.icBillElectricityPath;
      case BeneficiaryType.telecommunication:
        return AssetsManager.icBillTelecommunicationPath;
      case BeneficiaryType.inside:
        return AssetsManager.icTransferInsideBankPath;
      case BeneficiaryType.outside:
        return AssetsManager.icTransferBetweenBanksPath; // Default fallback
    }
  }

  /// **Returns an Icon based on BeneficiaryType**
  String get key {
    switch (this) {
      case BeneficiaryType.electricity:
        return 'Meter_No';
      case BeneficiaryType.telecommunication:
        return 'Pay_Customer_Code';
      case BeneficiaryType.inside:
        return 'Account_No';
      case BeneficiaryType.outside:
        return 'To_Card'; // Default fallback
    }
  }

  /// **Returns an Icon based on BeneficiaryType**
  int get id {
    switch (this) {
      case BeneficiaryType.electricity:
        return 6;
      case BeneficiaryType.telecommunication:
        return 4;
      case BeneficiaryType.inside:
        return 1;
      case BeneficiaryType.outside:
        return 2;
    }
  }
}
