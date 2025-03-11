import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/category_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/service_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/services/bank_services.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:get/get.dart';

class BankServicesViewModel extends GetxController{
  final BankServicesService _bankServicesService;

  final RxList<CategoryModel> _categories = <CategoryModel>[].obs;
  RxList<CategoryModel> get categories => _categories;

  final RxList<CategoryModel> _homeCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> get homeCategories => _homeCategories;

  final RxList<ServiceModel> _services = <ServiceModel>[].obs;
  RxList<ServiceModel> get services => _services;
  
  BankServicesViewModel(this._bankServicesService){
    _initialize();
  }
  
  void _initialize(){
    _fetchCategories();
  }

  Future _fetchCategories() async{
    _categories.value = await _bankServicesService.fetchCategories();
    _homeCategories.value = categories.where((e) => e.name != TranslationsKeys.tkStatementServiceLabel).toList();
    _homeCategories.add(CategoryModel(name: TranslationsKeys.tkBeneficiariesLabel, iconPath: AssetsManager.icBeneficiaryPath, route: RouteManager.beneficiaryRoute, services: []));
    final temp = <ServiceModel>[];
    for (var e in _categories) {
      temp.addAll(e.services);
    }
    _services.value = temp;
  }
  
  
}