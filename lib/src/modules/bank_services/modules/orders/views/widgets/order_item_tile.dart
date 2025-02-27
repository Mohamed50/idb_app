import 'package:az_banking_app/src/config/colors.dart';
import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/data/models/order_model.dart';
import 'package:az_banking_app/src/views/custom/custom_container.dart';
import 'package:az_banking_app/src/views/custom/custom_date_text.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';

class OrderItemTile extends StatelessWidget {
  final OrderModel orderModel;

  const OrderItemTile({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.subtitle(
                    TranslationsKeys.tkNameLabel,
                    fontSize: 12.0,
                  ),
                  CustomText.title(
                    orderModel.name,
                    fontSize: 14.0,
                  ),
                ],
              ),
              CustomCard(
                color: ColorManager.lightBackgroundColor,
                padding: EdgeInsets.symmetric(horizontal:12.0, vertical: 8.0),
                borderRadius: BorderRadius.circular(8),
                child: CustomText.title(orderModel.requestStatus, fontSize: 14.0, color: _getStatusColor(),),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.subtitle(
                    orderModel.comment.split(':').first,
                    fontSize: 12,
                  ),
                  CustomText.title(
                    orderModel.comment.split(':').last.trim(),
                    fontSize: 14.0,
                  ),
                ],
              ),
              CustomDateText(
                orderModel.tranDateTime,
                dateFormat: 'dd MMM',
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: ColorManager.titleColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (orderModel.requestStatus.toLowerCase()) {
      case 'pending':
        return Colors.amber;
      case 'rejected':
        return Colors.red;
      case 'approved':
        return Colors.green;
      default:
        return ColorManager.primaryColor;
    }
  }
}
