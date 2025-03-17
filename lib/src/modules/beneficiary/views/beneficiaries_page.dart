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

class BeneficiariesPage extends StatelessWidget {
  const BeneficiariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: TranslationsKeys.tkBeneficiariesLabel,
      ),
      body: GetX<BeneficiaryViewModel>(
        builder: (controller) => CustomVisible(
          show: controller.beneficiaries.isNotEmpty,
          placeHolder: Opacity(
            opacity: 0.1,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AssetsManager.icBeneficiaryPath, width: ScreenUtils.getScreenWidth(context, 0.6),),
                  SizedBox(height: 24.0),
                  CustomText.title(TranslationsKeys.tkNoBeneficiariesLabel, fontSize: 24.0,),
                ],
              ),
            ),
          ),
          child: BeneficiaryList(beneficiaries: controller.beneficiaries),
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
        color: ColorManager.darkBackgroundColor,
        child: ListTile(
          leading: CustomCard(
              color: ColorManager.lightBackgroundColor,
              child: Image.asset(beneficiaryModel.type.toIcon(), color: ColorManager.primaryColor,)),
          title: CustomText.title(
            beneficiaryModel.name,
            fontSize: 16.0,
            maxLines: 1,
          ),
          subtitle: CustomText.subtitle(beneficiaryModel.number, maxLines: 1,),
        ),
      ),
    );
  }

  void _handleBeneficiary() {
    BeneficiaryActions.instance.toBeneficiaryTransactionPage(beneficiaryModel);
  }
}
