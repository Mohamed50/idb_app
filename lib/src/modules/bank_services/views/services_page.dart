import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/bank_services/controllers/bank_services_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/category_model.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'category_tile.dart';

class BankServicesPage extends StatelessWidget {
  const BankServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightBackgroundColor,
      appBar: CustomAppbar(title: TranslationsKeys.tkServicesLabel,),
      body: GetX<BankServicesViewModel>(
        builder: (controller) => ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.all(24.0),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) => CategoryTile(controller.categories[index]),
          separatorBuilder: (context, index) => Divider(
            height: 32.0,
            thickness: 2,
            color: ColorManager.primaryColor.withValues(alpha: 0.08),
          ),
        ),
      ),
    );
  }
}
