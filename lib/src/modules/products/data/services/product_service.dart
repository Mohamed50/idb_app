import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/products/data/models/product_model.dart';

class ProductService extends ApiService{

  Future<List<ProductModel>> fetchProducts() async{
    final response = await post(APIConfiguration.fetchProductsUrl, {});
    return productModelFromJson(response.body['Products_List']);
  }

}