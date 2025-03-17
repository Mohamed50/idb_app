import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/category_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/service_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/services/bank_services.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:get/get.dart';

class BankServicesViewModel extends GetxController {
  final BankServicesService _bankServicesService;

  final RxList<CategoryModel> _categories = <CategoryModel>[].obs;

  RxList<CategoryModel> get categories => _categories;

  CategoryModel? get transferCategory => categories.firstWhereOrNull((e) => e.name == TranslationsKeys.tkTransferServicesLabel);

  final RxList<ServiceModel> _services = <ServiceModel>[].obs;

  RxList<ServiceModel> get services => _services;

  RxList<ServiceModel> get servicesWithoutTransfer =>
      _services.where((e) => !e.name.toLowerCase().contains('transfer')).toList().obs;

  BankServicesViewModel(this._bankServicesService) {
    _initialize();
  }

  void _initialize() {
    _fetchCategories();
    _fetchServices();
  }

  Future _fetchCategories() async {
    _categories.value = await _bankServicesService.fetchCategories();
  }

  Future _fetchServices() async {
    _services.value = await _bankServicesService.fetchServices();
  }
}
