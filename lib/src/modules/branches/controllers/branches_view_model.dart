import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/branches/data/models/branch_model.dart';
import 'package:az_banking_app/src/modules/branches/data/services/branches_services.dart';
import 'package:get/get.dart';

class BranchesViewModel extends GetxController {
  final BranchesService _branchesService;

  BranchesViewModel(this._branchesService) {
    _initialize();
  }

  final Rx<ApiResponse<List<BranchModel>>> _branchesLocations = ApiResponse<List<BranchModel>>.idle().obs;

  ApiResponse<List<BranchModel>> get branchesLocation => _branchesLocations.value;

  final Rx<ApiResponse<List<BranchModel>>> _branches = ApiResponse<List<BranchModel>>.idle().obs;

  ApiResponse<List<BranchModel>> get branches => _branches.value;

  void _initialize() {
    _fetchBranchesLocations();
  }

  _fetchBranchesLocations() {
    apiFetch(_branchesService.fetchBranchesLocations()).listen((value) => _branchesLocations.value = value);
  }

  fetchBranches() {
    apiFetch(_branchesService.fetchBranchesList()).listen((value) => _branches.value = value);
  }
}
