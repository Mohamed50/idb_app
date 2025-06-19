import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/beneficiary/controllers/beneficiary_view_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:az_banking_app/src/views/custom/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeneficiaryDropDown extends StatelessWidget {
  final BeneficiaryModel? value;
  final ValueChanged<BeneficiaryModel?> onChanged;
  final BeneficiaryType type;
  const BeneficiaryDropDown({super.key, this.value, required this.onChanged, required this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BeneficiaryViewModel>(
      builder: (controller) {
        List<BeneficiaryModel> options = [];
        switch(type) {
          case BeneficiaryType.electricity:
            options = controller.electricityBeneficiaries;
            break;
          case BeneficiaryType.telecommunication:
            options = controller.teleBeneficiaries;
            break;
          case BeneficiaryType.inside:
            options = controller.insideBeneficiaries;
            break;
          case BeneficiaryType.outside:
            options = controller.outsideBeneficiaries;
            break;
        }
        return CustomDropDown<BeneficiaryModel>(
          value: value,
          label: TranslationsKeys.tkBeneficiariesLabel,
          onChanged: onChanged,
          options: options,
        );
      },
    );
  }
}
