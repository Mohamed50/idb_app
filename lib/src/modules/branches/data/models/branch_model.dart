
import 'package:get/get.dart';

List<BranchModel> branchModelFromJson(List json) => List<BranchModel>.from(json.map((x) => BranchModel.fromJson(x)));


class BranchModel {
  final String nameAr;
  final String nameEn;
  final String code;
  final double? latitude;
  final double? longitude;

  BranchModel({
    required this.nameAr,
    required this.nameEn,
    required this.code,
    required this.latitude,
    required this.longitude,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    nameAr: json["Branch_Name_AR"] ?? json["Landmark_AR"] ?? '',
    nameEn: json["Branch_Name_EN"] ?? json["Landmard_EN"] ?? '',
    code: json["Branch_Code"] ?? '-1',
    latitude: json["Latitude"] != null ? double.parse(json["Latitude"]) : null,
    longitude: json["Longitude"] != null ? double.parse(json["Longitude"]): null,
  );

  Map<String, dynamic> toJson() => {
    "Branch_Name_AR": nameAr,
    "Branch_Name_En": nameEn,
    "Branch_Code": code,
    "Latitude": latitude,
    "Longitude": longitude,
  };


  @override
  String toString() {
    return Get.locale!.languageCode == 'en' ? nameEn : nameAr;
  }
}
