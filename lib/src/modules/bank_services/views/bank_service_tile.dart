import 'package:az_banking_app/src/modules/bank_services/actions/bank_service_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/service_model.dart';
import 'package:az_banking_app/src/modules/bank_services/views/service_icon_widget.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';

class BankServiceTile extends StatelessWidget {
  final ServiceModel serviceModel;

  const BankServiceTile({super.key, required this.serviceModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toServicePage,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: ServiceIconWidget2(iconPath: serviceModel.iconPath)),
          CustomText.title(
            serviceModel.name,
            fontSize: 14.0,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  void _toServicePage() {
    BankServicesActions.instance.toServicePage(serviceModel);
  }
}
