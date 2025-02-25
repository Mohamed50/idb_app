import 'dart:convert';

class UserModel {
  final String customerName;
  final String imageUri;
  final String phoneNo;
  final String deviceId;
  final bool isResetDeviceRequired;

  UserModel({
    required this.customerName,
    required this.imageUri,
    required this.phoneNo,
    required this.deviceId,
    required this.isResetDeviceRequired,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    customerName: json["Customer_Name"],
    imageUri: json["Image_URI"],
    phoneNo: json["Phone_No"],
    deviceId: json["Device_ID"],
    isResetDeviceRequired: json["reset_device"],
  );

  factory UserModel.fromString(String jsonString) => UserModel.fromJson(json.decode(jsonString));

  Map<String, dynamic> toJson() => {
    "Customer_Name": customerName,
    "Image_URI": imageUri,
    "Phone_No": phoneNo,
    "Device_ID": deviceId,
    "reset_device": isResetDeviceRequired,
  };
}
