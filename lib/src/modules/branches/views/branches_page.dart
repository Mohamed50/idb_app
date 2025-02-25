import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/branches/controllers/branches_view_model.dart';
import 'package:az_banking_app/src/modules/branches/data/models/branch_model.dart';
import 'package:az_banking_app/src/modules/branches/views/google_map_widget.dart';
import 'package:az_banking_app/src/views/custom/api_handler.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BranchesPage extends GetView<BranchesViewModel> {
  const BranchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: TranslationsKeys.tkBranchesLabel),
      body: ApiHandler(
        apiResponse: controller.branchesLocation,
        onSuccess: _OnSuccess(branches: controller.branchesLocation.data ?? []),
      ),
    );
  }
}

class _OnSuccess extends StatelessWidget {
  final List<BranchModel> branches;

  const _OnSuccess({required this.branches});

  @override
  Widget build(BuildContext context) {
    return GoogleMapWidget(
      locations: branches.map((e) => LatLng(e.latitude!, e.longitude!)).toList(),
    );
  }
}
