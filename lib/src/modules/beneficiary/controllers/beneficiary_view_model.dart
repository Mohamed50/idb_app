import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/services/beneficiary_service.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:get/get.dart';

class BeneficiaryViewModel extends GetxController {
  final BeneficiaryService _beneficiaryService;

  BeneficiaryViewModel(this._beneficiaryService) {
    _fetchBeneficiaries();
  }

  final RxList<BeneficiaryModel> _beneficiaries = <BeneficiaryModel>[].obs;

  RxList<BeneficiaryModel> get beneficiaries => _beneficiaries;

  final RxList<BeneficiaryModel> _insideBeneficiaries = <BeneficiaryModel>[].obs;

  RxList<BeneficiaryModel> get insideBeneficiaries => _insideBeneficiaries;

  final RxList<BeneficiaryModel> _outsideBeneficiaries = <BeneficiaryModel>[].obs;

  RxList<BeneficiaryModel> get outsideBeneficiaries => _outsideBeneficiaries;

  final RxList<BeneficiaryModel> _teleBeneficiaries = <BeneficiaryModel>[].obs;

  RxList<BeneficiaryModel> get teleBeneficiaries => _teleBeneficiaries;

  final RxList<BeneficiaryModel> _electricityBeneficiaries = <BeneficiaryModel>[].obs;

  RxList<BeneficiaryModel> get electricityBeneficiaries => _electricityBeneficiaries;

  Future<void> _fetchBeneficiaries() async {
    _beneficiaries.value = _beneficiaryService.fetchBeneficiaries();
    _groupBeneficiaries();
    update();
  }

  void _groupBeneficiaries() {
    _electricityBeneficiaries.clear();
    _insideBeneficiaries.clear();
    _outsideBeneficiaries.clear();
    _teleBeneficiaries.clear();
    for (var e in _beneficiaries) {
        switch (e.type) {
          case BeneficiaryType.electricity:
            _electricityBeneficiaries.add(e);
            break;
          case BeneficiaryType.telecommunication:
            _teleBeneficiaries.add(e);
            break;
          case BeneficiaryType.inside:
            _insideBeneficiaries.add(e);
            break;
          case BeneficiaryType.outside:
            _outsideBeneficiaries.add(e);
            break;
        }
      }
    update();
  }

  Future<void> addBeneficiary(BeneficiaryModel beneficiaryModel) async {
    if(!_beneficiaries.contains(beneficiaryModel)) {
      await _beneficiaryService.addBeneficiary(beneficiaryModel);
      _fetchBeneficiaries();
    }
    else{
      throw AppException(TranslationsKeys.tkBeneficiaryExistMsg);
    }
  }

  void refreshData() {
    _fetchBeneficiaries();
  }

  Future<void> removeBeneficiary(BeneficiaryModel beneficiaryModel) async {
    _beneficiaryService.removeBeneficiary(beneficiaryModel);
    await Future.delayed(Duration(milliseconds: 300));
    refreshData();
    update();
  }
}
