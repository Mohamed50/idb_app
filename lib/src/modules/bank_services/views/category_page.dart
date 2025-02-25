import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/category_model.dart';
import 'package:az_banking_app/src/modules/bank_services/views/bank_services_grid.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryModel categoryModel = Get.arguments;
    return Scaffold(
      backgroundColor: ColorManager.lightBackgroundColor,
      appBar: CustomAppbar(title: categoryModel.name),
      body: ServicesGrid(services: categoryModel.services),
    );
  }
}
