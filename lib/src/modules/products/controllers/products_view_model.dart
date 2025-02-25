import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/products/data/models/product_model.dart';
import 'package:az_banking_app/src/modules/products/data/services/product_service.dart';
import 'package:get/get.dart';

class ProductsViewModel extends GetxController {
  final ProductService _productsService;

  final Rx<ApiResponse<List<ProductModel>>> _products = ApiResponse<List<ProductModel>>.idle().obs;

  ApiResponse<List<ProductModel>> get products => _products.value;

  ProductsViewModel(this._productsService) {
    _initialize();
  }

  void _initialize() {
    _fetchProducts();
  }

  void _fetchProducts() {
    apiFetch(_productsService.fetchProducts()).listen((value) => _products.value = value);
  }
}
