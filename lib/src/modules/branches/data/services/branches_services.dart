import 'package:az_banking_app/src/essentials/config/api_config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/branches/data/models/branch_model.dart';

class BranchesService extends ApiService{

  Future<List<BranchModel>> fetchBranchesLocations() async{
    final response = await get(APIConfiguration.fetchBranchesLocationsUrl);
    return branchModelFromJson(response.body['Branches_List']);
  }

  Future<List<BranchModel>> fetchBranchesList() async{
    final response = await get(APIConfiguration.fetchBranchesListUrl);
    return branchModelFromJson(response.body['Branches_List']);
  }

}