import 'package:az_banking_app/src/modules/bank_services/modules/orders/data/models/order_model.dart';
import 'package:flutter/material.dart';

import 'order_item_tile.dart';

class OrdersListView extends StatelessWidget {
  final List<OrderModel> orders;
  const OrdersListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(24.0),
      itemCount: orders.length,
      itemBuilder: (context, index) => OrderItemTile(orderModel: orders[index]),
      separatorBuilder: (context, index) => SizedBox(height: 12.0,),
    );
  }
}
