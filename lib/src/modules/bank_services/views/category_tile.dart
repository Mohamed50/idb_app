import 'package:az_banking_app/src/modules/bank_services/data/model/category_model.dart';
import 'package:az_banking_app/src/modules/bank_services/views/bank_service_tile.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryTile(this.categoryModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.title(categoryModel.name),
        SizedBox(height: 12.0),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          childAspectRatio: 1.0,
          padding: EdgeInsets.zero,
          children: categoryModel.services.map((e) => BankServiceTile(serviceModel: e)).toList(),
        )
      ],
    );
  }
}
