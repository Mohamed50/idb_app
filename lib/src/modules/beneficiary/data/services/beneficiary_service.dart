import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_api_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';

class BeneficiaryService extends ApiService {
  Future<List<BeneficiaryModel>> fetchBeneficiaries() async {
    final response = await get(APIConfiguration.fetchBeneficiariesUrl);
    return beneficiaryModelFromJson(response.body['Favorites_List'])
        .map((e) => BeneficiaryModel(id: e.id, number: e.values.first.keyValue, name: e.name, type: e.type.beneficiaryType))
        .toList();
  }

  Future<bool> addBeneficiary(BeneficiaryModel beneficiaryModel) async {
    final body = {
      "Favorite_Value": [
        {"Key_Name": beneficiaryModel.type.key, "Key_Value": beneficiaryModel.number, "Key_Disp_Value": beneficiaryModel.number}
      ],
      "Favorite_Name": beneficiaryModel.name,
      "Favorite_Type": beneficiaryModel.type.id,
      "Favorite_Order": beneficiaryModel.type.id,
    };
    await post(APIConfiguration.addBeneficiariesUrl, body);
    return true;
  }

  Future<bool> updateBeneficiary(BeneficiaryModel beneficiaryModel) async {
    final body = {
      "Favorite_ID" : beneficiaryModel.id,
      "Favorite_Value": [
        {"Key_Name": beneficiaryModel.type.key, "Key_Value": beneficiaryModel.number, "Key_Disp_Value": beneficiaryModel.number}
      ],
      "Favorite_Name": beneficiaryModel.name,
      "Favorite_Type": beneficiaryModel.type.id,
      "Favorite_Order": beneficiaryModel.type.id,
    };
    await post(APIConfiguration.updateBeneficiariesUrl, body);
    return true;
  }

  Future<bool> removeBeneficiary(BeneficiaryModel beneficiaryModel) async {
    final Map<String, dynamic> body = {"Favorite_ID": beneficiaryModel.id};
    await post(APIConfiguration.deleteBeneficiariesUrl, body);
    return true;
  }
}
