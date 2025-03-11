import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/bank_services/actions/bank_service_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/controllers/bank_services_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/category_model.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'service_icon_widget.dart';

class BankCategoriesWidget extends StatelessWidget {
  const BankCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<BankServicesViewModel>(
      builder: (controller) => SizedBox(
        height: ScreenUtils.getScreenHeight(context, 0.11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4,(index) => _CategoryTile(categoryModel: controller.homeCategories[index])).toList(),
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final CategoryModel categoryModel;

  const _CategoryTile({required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: InkWell(
        onTap: _toCategoryPage,
        child: Column(
          children: [
            ServiceIconWidget(iconPath: categoryModel.iconPath),
            SizedBox(height: 4.0),
            CustomText.title(
              categoryModel.name,
              fontSize: 16.0,
            ),
          ],
        ),
      ),
    );
  }

  void _toCategoryPage() {
    BankServicesActions.instance.toCategoryPage(categoryModel);
  }
}
