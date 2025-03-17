import 'package:az_banking_app/src/modules/bank_services/controllers/bank_services_view_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/service_model.dart';
import 'package:az_banking_app/src/modules/bank_services/views/bank_service_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankServicesGrid extends StatelessWidget {
  const BankServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<BankServicesViewModel>(
      builder: (controller) => GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.servicesWithoutTransfer.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 24.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) => BankServiceTile(serviceModel: controller.services[index]),
      ),
    );
  }
}

class ServicesGrid extends StatelessWidget {
  final List<ServiceModel> services;

  const ServicesGrid({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: services.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(24.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) => BankServiceTile(serviceModel: services[index]),
    );
  }
}
