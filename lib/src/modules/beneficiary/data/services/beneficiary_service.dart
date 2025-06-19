import 'package:az_banking_app/src/essentials/services/memory_service.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:get/get.dart';

class BeneficiaryService extends GetxController {
  List<BeneficiaryModel> fetchBeneficiaries() {
    String beneficiaries = MemoryService.instance.beneficiaries ?? '[]';
    return beneficiaryListFromJson(beneficiaries);
  }

  Future<bool> addBeneficiary(BeneficiaryModel beneficiaryModel) async {
    String json = MemoryService.instance.beneficiaries ?? '[]';
    final beneficiaries = beneficiaryListFromJson(json);
    beneficiaries.add(beneficiaryModel);
    MemoryService.instance.beneficiaries = beneficiaryListToJson(beneficiaries);
    await Future.delayed(Duration(milliseconds: 300));
    return true;
  }

  bool removeBeneficiary(BeneficiaryModel beneficiaryModel) {
    String json = MemoryService.instance.beneficiaries ?? '[]';
    final beneficiaries = beneficiaryListFromJson(json);
    beneficiaries.removeWhere((e) => e.number == beneficiaryModel.number);
    MemoryService.instance.beneficiaries = beneficiaryListToJson(beneficiaries);
    return true;
  }
}
