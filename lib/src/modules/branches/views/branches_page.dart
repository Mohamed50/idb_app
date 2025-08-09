import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/branches/controllers/branches_view_model.dart';
import 'package:az_banking_app/src/modules/branches/data/models/branch_model.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BranchesPage extends GetView<BranchesViewModel> {
  const BranchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: TranslationsKeys.tkBranchesLabel),
      backgroundColor: ColorManager.darkBackgroundColor,
      body: Obx(
        ()=> ApiHandler(
          apiResponse: controller.branchesLocation,
          onSuccess: _OnSuccess(branches: controller.branchesLocation.data ?? []),
        ),
      ),
    );
  }
}
//
// class _OnSuccess extends StatelessWidget {
//   final List<BranchModel> branches;
//
//   const _OnSuccess({required this.branches});
//
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMapWidget(
//       locations: branches.map((e) => LatLng(e.latitude!, e.longitude!)).toList(),
//     );
//   }
// }

class _OnSuccess extends StatelessWidget {
  final List<BranchModel> branches;

  const _OnSuccess({required this.branches});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(24.0),
      itemCount: branches.length,
      itemBuilder: (context, index) => BranchItemTile(branchModel: branches[index]),
      separatorBuilder: (context, index) => SizedBox(height: 12.0),
    );
  }
}

class BranchItemTile extends StatelessWidget {
  final BranchModel branchModel;

  const BranchItemTile({super.key, required this.branchModel});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: ColorManager.lightBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.subtitle(
                  TranslationsKeys.tkBranchesLabel,
                  fontSize: 10,
                ),
                CustomTranslatedText(
                  textEn: branchModel.nameEn,
                  textAr: branchModel.nameEn,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          CustomButton(
            width:100,
            text: TranslationsKeys.tkAddressLabel, onPressed: _onPressed,),
        ],
      ),
    );
  }

  void _onPressed() {
    launchUrlString('https://www.google.com/maps/search/?api=1&query=${branchModel.latitude},${branchModel.longitude}');
  }
}
