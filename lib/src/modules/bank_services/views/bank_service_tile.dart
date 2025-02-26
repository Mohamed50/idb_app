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
    final itemWidth = (ScreenUtils.getScreenWidth(context) - 48 - (8 * 5)) / 5;
    return FittedBox(
      child: SizedBox(
        width: itemWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: _toServicePage,
              child: CustomCard(
                color: ColorManager.primaryColor.withValues(alpha: 0.08),
                padding: EdgeInsets.all(8.0),
                child: CustomCard(
                  color: ColorManager.primaryColor.withValues(alpha: 0.08),
                  padding: EdgeInsets.all(4.0),
                  child: Image.asset(
                    serviceModel.iconPath,
                    width: 40,
                    height: 40,
                    color: ColorManager.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.0),
            CustomText.title(
              serviceModel.name,
              fontSize: 14,
              textAlign: TextAlign.center,
              maxLines: 1,
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
