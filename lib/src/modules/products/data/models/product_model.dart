List<ProductModel> productModelFromJson(List json) => List<ProductModel>.from(json.map((x) => ProductModel.fromJson(x)));


class ProductModel {
  final int productId;
  final String productName;
  final String orderId;
  final String productUri;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.orderId,
    required this.productUri,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productId: json["Product_Id"],
    productName: json["Product_Name"],
    orderId: json["Order_Id"] ?? '',
    productUri: json["Product_Uri"],
  );

  Map<String, dynamic> toJson() => {
    "Product_Id": productId,
    "Product_Name": productName,
    "Order_Id": orderId,
    "Product_Uri": productUri,
  };
}
