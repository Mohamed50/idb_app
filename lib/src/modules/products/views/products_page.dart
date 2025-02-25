import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/products/controllers/products_view_model.dart';
import 'package:az_banking_app/src/views/custom/api_handler.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/products_list_view.dart';

class ProductsPage extends GetView<ProductsViewModel> {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: TranslationsKeys.tkProductsServiceLabel),
      body: Obx(
        () => ApiHandler(
          apiResponse: controller.products,
          onSuccess: ProductsListView(products: controller.products.data ?? []),
        ),
      ),
    );
  }
}
