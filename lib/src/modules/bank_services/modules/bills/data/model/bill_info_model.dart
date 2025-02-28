List<BillInfoModel> billInfoModelFromJson(List json) => List<BillInfoModel>.from(json.map((x) => BillInfoModel.fromJson(x)));

class BillInfoModel {
  final String label;
  final String value;

  BillInfoModel({
    required this.label,
    required this.value,
  });

  factory BillInfoModel.fromJson(Map<String, dynamic> json) => BillInfoModel(
        label: json["Info_Lable"],
        value: json["Info_Value"],
      );

  Map<String, dynamic> toJson() => {
        "Info_Lable": label,
        "Info_Value": value,
      };
}
