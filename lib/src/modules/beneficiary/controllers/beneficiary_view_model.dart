import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/services/beneficiary_service.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:get/get.dart';

class BeneficiaryViewModel extends GetxController {
  final BeneficiaryService _beneficiaryService;

  BeneficiaryViewModel(this._beneficiaryService);

  @override
  void onInit() {
    _fetchBeneficiaries();
    super.onInit();
  }

  List<BeneficiaryModel> _beneficiaries = <BeneficiaryModel>[].obs;

  List<BeneficiaryModel> get beneficiaries => _beneficiaries;

  List<BeneficiaryModel> get insideBeneficiaries => _beneficiaries.where((e) => e.type == BeneficiaryType.inside).toList();

  List<BeneficiaryModel> get outsideBeneficiaries => _beneficiaries.where((e) => e.type == BeneficiaryType.outside).toList();

  List<BeneficiaryModel> get teleBeneficiaries =>
      _beneficiaries.where((e) => e.type == BeneficiaryType.telecommunication).toList();

  List<BeneficiaryModel> get electricityBeneficiaries =>
      _beneficiaries.where((e) => e.type == BeneficiaryType.electricity).toList();

  Future<void> _fetchBeneficiaries() async {
    _beneficiaries = await _beneficiaryService.fetchBeneficiaries();
    update();
  }

  Future<void> addBeneficiary(BeneficiaryModel beneficiaryModel) async {
    if (!_beneficiaries.any((e) => e.number == beneficiaryModel.number)) {
      await _beneficiaryService.addBeneficiary(beneficiaryModel);
      _fetchBeneficiaries();
    } else {
      throw AppException(TranslationsKeys.tkBeneficiaryExistMsg);
    }
  }

  void refreshData() {
    _fetchBeneficiaries();
  }

  Future<void> updateBeneficiary(BeneficiaryModel beneficiaryModel) async {
    await _beneficiaryService.updateBeneficiary(beneficiaryModel);
    refreshData();
    update();
  }

  Future<void> removeBeneficiary(BeneficiaryModel beneficiaryModel) async {
    await _beneficiaryService.removeBeneficiary(beneficiaryModel);
    refreshData();
    update();
  }
}
