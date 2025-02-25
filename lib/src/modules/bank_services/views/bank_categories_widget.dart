import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/bank_services/actions/bank_service_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/controllers/bank_services_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/category_model.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankCategoriesWidget extends StatelessWidget {
  const BankCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<BankServicesViewModel>(
      builder: (controller) => SizedBox(
        height: ScreenUtils.getScreenHeight(context, 0.11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: controller.homeCategories.map((e) => _CategoryTile(categoryModel: e)).toList(),
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
    final itemWidth = (ScreenUtils.getScreenWidth(context) - 48 - (8* 4)) / 4;
    return InkWell(
      onTap: _toCategoryPage,
      child: SizedBox(
        width: itemWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomCard(
              color: ColorManager.primaryColor.withValues(alpha: 0.08),
              padding: EdgeInsets.all(8.0),
              child: CustomCard(
                color: ColorManager.primaryColor.withValues(alpha: 0.08),
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  categoryModel.iconPath,
                  width: 40,
                  height: 40,
                  color: ColorManager.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 2.0),
            CustomText.title(
              categoryModel.name,
              fontSize: 14,
              textAlign: TextAlign.center,
              maxLines: 1,
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
