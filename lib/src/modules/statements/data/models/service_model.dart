
List<ServiceModel> serviceModelFromJson(List json) => List<ServiceModel>.from(json.map((x) => ServiceModel.fromJson(x)));


class ServiceModel {
  final String serviceName;
  final String serviceCode;

  ServiceModel({
    required this.serviceName,
    required this.serviceCode,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    serviceName: json["Service_Name"],
    serviceCode: json["Service_Code"],
  );

  Map<String, dynamic> toJson() => {
    "Service_Name": serviceName,
    "Service_Code": serviceCode,
  };

  @override
  String toString() {
    return serviceName;
  }
}
