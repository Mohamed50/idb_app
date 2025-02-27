import 'package:az_banking_app/src/config/colors.dart';
import 'package:az_banking_app/src/modules/bank_services/actions/bank_service_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/service_model.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/custom_container.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';

class BankServiceTile extends StatelessWidget {
  final ServiceModel serviceModel;

  const BankServiceTile({super.key, required this.serviceModel});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: InkWell(
        onTap: _toServicePage,
        child: Column(
          children: [
            CustomCard(
              color: ColorManager.darkBackgroundColor,
              child: CustomCard(
                color: Colors.white,
                child: Image.asset(serviceModel.iconPath, width: 40, height: 40),
              ),
            ),
            SizedBox(height: 4.0),
            CustomText.title(
              serviceModel.name,
              fontSize: 12.0,
            ),
          ],
        ),
      ),
    );
  }

  void _toServicePage() {
    BankServicesActions.instance.toServicePage(serviceModel);
  }
}
