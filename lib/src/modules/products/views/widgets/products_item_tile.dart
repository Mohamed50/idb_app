import 'package:az_banking_app/src/config/colors.dart';
import 'package:az_banking_app/src/modules/products/data/models/product_model.dart';
import 'package:az_banking_app/src/views/custom/custom_container.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';

class ProductItemTile extends StatelessWidget {
  final ProductModel productModel;

  const ProductItemTile({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: ColorManager.darkBackgroundColor,
      padding: EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(productModel.productUri),
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(flex: 3, child: CustomText.title(productModel.productName)),
        ],
      ),
    );
  }
}
