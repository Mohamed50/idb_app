import 'dart:convert';

import 'package:az_banking_app/src/config/config.dart';

/// **Enum representing different beneficiary types**
enum BeneficiaryType { electricity, telecommunication, inside, outside }

/// **Model class for a Beneficiary**
class BeneficiaryModel {
  final String number;
  final String name;
  final BeneficiaryType type;

  BeneficiaryModel(this.number, this.name, this.type);

  /// **Convert BeneficiaryModel to JSON**
  Map<String, dynamic> toJson() {
    return {
      "number": number,
      "name": name,
      "type": type.toString().split('.').last, // Convert Enum to String
    };
  }

  /// **Create BeneficiaryModel from JSON**
  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    return BeneficiaryModel(
      json["number"],
      json["name"],
      BeneficiaryType.values.firstWhere((e) => e.toString().split('.').last == json["type"]),
    );
  }
}

/// **Convert List of BeneficiaryModel to JSON String**
String beneficiaryListToJson(List<BeneficiaryModel> beneficiaries) {
  List<Map<String, dynamic>> jsonList =
  beneficiaries.map((b) => b.toJson()).toList();
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
        return AssetsManager.icTransferBetweenBanksPath;// Default fallback
    }
  }
}