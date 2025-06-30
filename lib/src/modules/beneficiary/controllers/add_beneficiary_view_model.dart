import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_type_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/tele_provider_enum.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/tele_service_type.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/data/services/transfer_service.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/services/beneficiary_service.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:get/get.dart';

class AddBeneficiaryViewModel extends GetxController {
  BeneficiaryModel beneficiaryModel;
  final BeneficiaryService _beneficiaryService;
  final TransferService _transferService;

  AddBeneficiaryViewModel(
    this._beneficiaryService,
    this.beneficiaryModel,
    this._transferService,
  );

  AccountModel? toAccount;
  final AccountType _toAccountType = AccountType.ntd;

  Future<void> addBeneficiary(BeneficiaryModel beneficiaryModel) async {
    if (beneficiaryModel.type == BeneficiaryType.inside) {
      await fetchReceiverInfoInsideBank();
    } else if (beneficiaryModel.type == BeneficiaryType.outside) {
      await fetchReceiverInfoOutsideBank();
    } else {
      // _beneficiaryService.addBeneficiary(beneficiaryModel);
    }
  }

  void onNumberChanged(String? newValue) {
    if (newValue != null) {
      beneficiaryModel.number = newValue;
    }
  }

  void onNameChanged(String? newValue) {
    if (newValue != null) {
      beneficiaryModel.name = newValue;
    }
  }

  void onTypeChanged(BeneficiaryType? newValue) {
    if (newValue != null) {
      beneficiaryModel.type = newValue;
      update();
    }
  }

  void onProviderChanged(TeleProvider? newValue) {
    if (newValue != null) {
      beneficiaryModel.provider = newValue;
      update();
    }
  }

  void onServiceTypeChanged(TeleServiceType? newValue) {
    if (newValue != null) {
      beneficiaryModel.serviceType = newValue;
    }
  }

  Future fetchReceiverInfo() async {
    if(beneficiaryModel.type == BeneficiaryType.inside){
      await fetchReceiverInfoInsideBank();
    }
    else{
      await fetchReceiverInfoOutsideBank();
    }
  }


  Future fetchReceiverInfoInsideBank() async {
    toAccount = await _transferService.fetchAccountInfoInsideBank(
      beneficiaryModel.number,
      _toAccountType.toCode(),
    );
    if (!isInfoAvailable()) {
      throw APIException(TranslationsKeys.tkAccountInfoNotAvailableMsg);
    }
    beneficiaryModel.name = toAccount!.name;
    beneficiaryModel.name = toAccount!.name;
    update();
  }

  Future fetchReceiverInfoOutsideBank() async {
    toAccount = await _transferService.fetchAccountInfoOutsideBank(beneficiaryModel.number!);
    update();
  }

  bool isInfoAvailable() {
    return toAccount?.name != null && toAccount!.name.isNotEmpty;
  }

  bool isReady(){
    if((beneficiaryModel.type == BeneficiaryType.inside || beneficiaryModel.type == BeneficiaryType.outside) && toAccount == null){
      return false;
    }
    else{
      return true;
    }
  }
}
