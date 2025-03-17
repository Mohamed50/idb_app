import 'package:az_banking_app/src/modules/bank_services/actions/bank_service_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/controllers/bank_services_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/service_model.dart';
import 'package:az_banking_app/src/modules/bank_services/views/bank_service_tile.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'service_icon_widget.dart';

class TransferServicesWidget extends StatelessWidget {
  const TransferServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<BankServicesViewModel>(
      builder: (controller) {
        if (controller.transferCategory != null) {
          return SizedBox(
            height: ScreenUtils.getScreenHeight(context, 0.11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                controller.transferCategory!.services.length,
                (index) => _BankServiceTile(
                  serviceModel: controller.transferCategory!.services[index],
                ),
              ).toList(),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _BankServiceTile extends StatelessWidget {
  final ServiceModel serviceModel;

  const _BankServiceTile({super.key, required this.serviceModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toServicePage,
      child: AspectRatio(
        aspectRatio: 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ServiceIconWidget3(iconPath: serviceModel.iconPath),
            SizedBox(height: 4.0),
            CustomText.title(
              serviceModel.name,
              fontSize: 14.0,
              color: Colors.white,
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
