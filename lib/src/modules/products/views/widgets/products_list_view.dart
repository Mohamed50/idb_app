import 'package:az_banking_app/src/modules/products/data/models/product_model.dart';
import 'package:az_banking_app/src/modules/products/views/widgets/products_item_tile.dart';
import 'package:flutter/material.dart';

class ProductsListView extends StatelessWidget {
  final List<ProductModel> products;

  const ProductsListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      padding: EdgeInsets.all(24.0),
      itemBuilder: (context, index) => ProductItemTile(productModel: products[index]),
      separatorBuilder: (context, index) => SizedBox(height: 24.0),
    );
  }
}
