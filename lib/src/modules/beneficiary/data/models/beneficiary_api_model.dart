import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';

List<BeneficiaryApiModel> beneficiaryModelFromJson(List json) =>
    List<BeneficiaryApiModel>.from(json.map((x) => BeneficiaryApiModel.fromJson(x)));

class BeneficiaryApiModel {
  final List<BeneficiaryValue> values;
  final int id;
  final int type;
  final String name;
  final int order;

  BeneficiaryApiModel({
    required this.values,
    required this.id,
    required this.type,
    required this.name,
    required this.order,
  });

  factory BeneficiaryApiModel.fromJson(Map<String, dynamic> json) => BeneficiaryApiModel(
        values: List<BeneficiaryValue>.from(json["Favorite_Value"].map((x) => BeneficiaryValue.fromJson(x))),
        id: json["Favorite_ID"],
        type: json["Favorite_Type"],
        name: json["Favorite_Name"],
        order: json["Favorite_Order"],
      );

  Map<String, dynamic> toJson() => {
        "Favorite_Value": List<dynamic>.from(values.map((x) => x.toJson())),
        "Favorite_ID": id,
        "Favorite_Type": type,
        "Favorite_Name": name,
        "Favorite_Order": order,
      };
}

class BeneficiaryValue {
  final String keyValue;
  final String keyName;
  final String keyDispValue;

  BeneficiaryValue({
    required this.keyValue,
    required this.keyName,
    required this.keyDispValue,
  });

  factory BeneficiaryValue.fromJson(Map<String, dynamic> json) => BeneficiaryValue(
        keyValue: json["Key_Value"],
        keyName: json["Key_Name"],
        keyDispValue: json["Key_Disp_Value"],
      );

  Map<String, dynamic> toJson() => {
        "Key_Value": keyValue,
        "Key_Name": keyName,
        "Key_Disp_Value": keyDispValue,
      };
}

extension BeneficiaryExtension on int {
  /// **Returns an Icon based on BeneficiaryType**
  BeneficiaryType get beneficiaryType {
    switch (this) {
      case 6:
        return BeneficiaryType.electricity;
      case 4:
        return BeneficiaryType.telecommunication;
      case 1:
        return BeneficiaryType.inside;
      case 2:
        return BeneficiaryType.outside;
      default:
        return BeneficiaryType.inside;
    }
  }
}
