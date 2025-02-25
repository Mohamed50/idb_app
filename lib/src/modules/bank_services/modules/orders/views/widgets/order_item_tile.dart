import 'package:az_banking_app/src/config/colors.dart';
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
      padding: EdgeInsets.all(12.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
            decoration: BoxDecoration(
              color: _getStatusColor().withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(24.0),
              // border: Border.all(color: _getStatusColor()),
            ),
            child: CustomText.title(
              orderModel.requestStatus,
              fontSize: 12.0,
              color: _getStatusColor(),
            ),
          ),
          SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.title(
                orderModel.name,
                fontSize: 18.0,
              ),
              CustomText.subtitle(orderModel.comment),
              SizedBox(height: 4.0),
              CustomDateText(
                orderModel.tranDateTime,
                dateFormat: 'dd-MMM-yyyy hh:mm',
                fontSize: 14.0,
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
