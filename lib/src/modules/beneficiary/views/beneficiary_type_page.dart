import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/beneficiary/actions/beneficiary_actions.dart';
import 'package:az_banking_app/src/modules/beneficiary/controllers/beneficiary_view_model.dart';
import 'package:az_banking_app/src/modules/beneficiary/data/models/beneficiary_model.dart';
import 'package:az_banking_app/src/utils/screen_utils.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:az_banking_app/src/views/custom/custom_container.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:az_banking_app/src/views/custom/custom_visible.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeneficiaryTypePage extends StatelessWidget {
  final List<BeneficiaryModel> beneficiaries;

  const BeneficiaryTypePage({super.key, required this.beneficiaries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkBackgroundColor,
      appBar: CustomAppbar(
        title: TranslationsKeys.tkBeneficiariesLabel,
      ),
      body: CustomVisible(
        show: beneficiaries.isNotEmpty,
        placeHolder: Opacity(
          opacity: 0.1,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AssetsManager.icBeneficiaryPath,
                  width: ScreenUtils.getScreenWidth(context, 0.6),
                ),
                SizedBox(height: 24.0),
                CustomText.title(
                  TranslationsKeys.tkNoBeneficiariesLabel,
                  fontSize: 24.0,
                ),
              ],
            ),
          ),
        ),
        child: GetBuilder<BeneficiaryViewModel>(
          builder: (controller) => BeneficiaryList(beneficiaries: beneficiaries),
        ),
      ),
    );
  }
}

class BeneficiaryList extends StatelessWidget {
  final List<BeneficiaryModel> beneficiaries;

  const BeneficiaryList({super.key, required this.beneficiaries});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(24.0),
      itemCount: beneficiaries.length,
      itemBuilder: (context, index) => BeneficiaryItemTile(beneficiaryModel: beneficiaries[index]),
      separatorBuilder: (context, index) => SizedBox(height: 12.0),
    );
  }
}

class BeneficiaryItemTile extends StatelessWidget {
  final BeneficiaryModel beneficiaryModel;

  const BeneficiaryItemTile({super.key, required this.beneficiaryModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleBeneficiary,
      child: CustomCard(
        color: ColorManager.lightBackgroundColor,
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            CustomCard(
              color: ColorManager.negativeColor.withValues(alpha: 0.08),
              child: Image.asset(
                beneficiaryModel.type.toIcon(),
                width: 48.0,
                color: ColorManager.primaryColor,
              ),
            ),
            SizedBox(width: 24.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.title(
                    beneficiaryModel.name,
                    fontSize: 16.0,
                    maxLines: 1,
                  ),
                  CustomText.subtitle(
                    beneficiaryModel.number,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            CustomCard(
              shape: BoxShape.circle,
              color: Colors.amber.withValues(alpha: 0.3),
              child: InkWell(
                onTap: () => _updateBeneficiary(context),
                child: Icon(Icons.edit, color: Colors.amber),
              ),
            ),
            SizedBox(width: 4.0),
            CustomCard(
              shape: BoxShape.circle,
              color: ColorManager.negativeColor.withValues(alpha: 0.3),
              child: InkWell(
                onTap: () => _removeBeneficiary(context),
                child: Icon(Icons.delete, color: ColorManager.negativeColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleBeneficiary() {
    BeneficiaryActions.instance.toBeneficiaryTransactionPage(beneficiaryModel);
  }

  void _removeBeneficiary(BuildContext context) {
    BeneficiaryActions.instance.removeBeneficiary(context, beneficiaryModel);
  }

  void _updateBeneficiary(BuildContext context) {
    BeneficiaryActions.instance.toEditBeneficiaryPage(beneficiaryModel);
  }
}
