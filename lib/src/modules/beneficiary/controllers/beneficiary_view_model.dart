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

  void _fetchBeneficiaries() {
    _beneficiaries.value = _beneficiaryService.fetchBeneficiaries();
    _groupBeneficiaries();
  }

  void _groupBeneficiaries() {
    _beneficiaries.map(
      (e) {
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
      },
    );
  }

  void addBeneficiary(BeneficiaryModel beneficiaryModel){
    _beneficiaryService.addBeneficiary(beneficiaryModel);
  }
}
