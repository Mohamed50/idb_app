import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/controllers/order_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/views/widgets/orders_list_view.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackOrderStatusPage extends GetView<OrderViewModel> {
  const TrackOrderStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(TranslationsKeys.tkTrackOrdersStatusServiceLabel),
      ),
      body: Obx(
        () => ApiHandler(
          apiResponse: controller.orders,
          onSuccess: OrdersListView(orders: controller.orders.data ?? []),
        ),
      ),
    );
  }
}
