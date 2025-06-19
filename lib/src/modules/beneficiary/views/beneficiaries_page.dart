import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/beneficiary/actions/beneficiary_actions.dart';
import 'package:az_banking_app/src/modules/beneficiary/controllers/beneficiary_view_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:az_banking_app/src/views/custom/custom_container.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BeneficiariesPage extends StatelessWidget {
  const BeneficiariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<BeneficiaryViewModel>().refreshData();
    return Scaffold(
      backgroundColor: ColorManager.darkBackgroundColor,
      appBar: CustomAppbar(
        title: TranslationsKeys.tkBeneficiariesLabel,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toAddBeneficiaryPage,
        backgroundColor: ColorManager.primaryColor,
        child: FaIcon(FontAwesomeIcons.plus),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GetBuilder<BeneficiaryViewModel>(
          builder: (controller) =>  Column(
            children: [
              BeneficiaryTypeItemTile(type: BeneficiaryType.inside),
              SizedBox(height: 12.0),
              BeneficiaryTypeItemTile(type: BeneficiaryType.outside),
              SizedBox(height: 12.0),
              BeneficiaryTypeItemTile(type: BeneficiaryType.electricity),
              SizedBox(height: 12.0),
              BeneficiaryTypeItemTile(type: BeneficiaryType.telecommunication),
            ],
          ),
        ),
      ),
    );
  }

  void _toAddBeneficiaryPage() {
    BeneficiaryActions.instance.toAddBeneficiaryPage();
  }
}

class BeneficiaryTypeItemTile extends StatelessWidget {
  final BeneficiaryType type;

  const BeneficiaryTypeItemTile({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final beneficiaries = BeneficiaryActions.instance.getBeneficiariesByType(type);
    return InkWell(
      onTap: _toBeneficiaryTypePage,
      child: CustomCard(
        color: ColorManager.lightBackgroundColor,
        child: ListTile(
          leading: CustomCard(
            color: ColorManager.negativeColor.withValues(alpha: 0.08),
            child: Image.asset(
              type.toIcon(),
              color: ColorManager.primaryColor,
            ),
          ),
          title: CustomText.title(
            type.toString(),
            fontSize: 16.0,
            maxLines: 1,
          ),
          subtitle: CustomText.subtitle(
            beneficiaries.length.toString(),
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  void _toBeneficiaryTypePage() {
    BeneficiaryActions.instance.toBeneficiaryTypePage(type);
  }
}
