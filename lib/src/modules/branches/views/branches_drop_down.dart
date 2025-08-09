import 'package:az_banking_app/src/modules/branches/controllers/branches_view_model.dart';
import 'package:az_banking_app/src/modules/branches/data/models/branch_model.dart';
import 'package:az_banking_app/src/views/custom/api_handler.dart';
import 'package:az_banking_app/src/views/custom/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchesDropDown extends GetView<BranchesViewModel> {
  final String label;
  final ValueChanged<BranchModel?>? onSaved;
  final FormFieldValidator<BranchModel>? validator;
  const BranchesDropDown( {super.key, required this.label, this.onSaved, this.validator,});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiHandler(
        apiResponse: controller.branches,
        onSuccess: CustomDropDown<BranchModel>(
          label: label,
          options: controller.branches.data ?? <BranchModel>[],
          onSaved: onSaved,
          validator: validator,
        ),
      ),
    );
  }
}
