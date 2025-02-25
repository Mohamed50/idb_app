import 'package:az_banking_app/src/modules/bank_services/modules/bills/controllers/tele_bills_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/data/model/tele_provider_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeleProviderPicker extends StatelessWidget {
  const TeleProviderPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<TeleBillsViewModel>(
      builder: (controller) => Row(
        children: [TeleProvider.zain, TeleProvider.mtn, TeleProvider.sudani]
            .map((e) => Expanded(
                  child: TeleProviderItem(
                    teleProvider: e,
                    selected: controller.selectedProvider == e,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class TeleProviderItem extends StatelessWidget {
  final TeleProvider teleProvider;
  final bool selected;

  const TeleProviderItem({super.key, required this.teleProvider, required this.selected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.find<TeleBillsViewModel>().onProviderChange(teleProvider),
      child: AspectRatio(
        aspectRatio: 1.8,
        child: Opacity(
          opacity: selected ? 1.0 : 0.5,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.symmetric(horizontal: selected ? 6.0 : 12.0),
            margin: EdgeInsets.symmetric(horizontal: 6.0),
            decoration: BoxDecoration(
              color: teleProvider.toColor(),
              border: Border.all(color: teleProvider.toColor(), width: selected ? 5 : 0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Image.asset(teleProvider.toIconPath()),
          ),
        ),
      ),
    );
  }
}
