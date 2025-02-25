import 'dart:typed_data';

import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/bank_services/actions/bank_service_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/service_config.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/custom_container.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class ResponsePage extends StatelessWidget {
  static final screenshotController = ScreenshotController();

  const ResponsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> response = Get.arguments;
    final children = ServicesConfiguration.getServiceResponseItems(response);
    return Scaffold(
      body: SafeArea(
        child: Screenshot(
          controller: screenshotController,
          child: Container(
            color: ColorManager.darkBackgroundColor,
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomCard(
                  shape: BoxShape.circle,
                  padding: EdgeInsets.all(24.0),
                  color: ColorManager.positiveColor,
                  child: FaIcon(
                    FontAwesomeIcons.check,
                    size: 80,
                    color: ColorManager.lightBackgroundColor,
                  ),
                ),
                SizedBox(height: 4.0),
                CustomText.title(TranslationsKeys.tkSuccessfulTransactionMsg),
                SizedBox(height: 32.0),
                Expanded(
                  child: CustomCard(
                    child: ListView.separated(
                      padding: EdgeInsets.all(12.0),
                      shrinkWrap: true,
                      itemCount: children.length,
                      itemBuilder: (context, index) => children[index],
                      separatorBuilder: (context, index) => Divider(
                        color: ColorManager.titleColor,
                        thickness: 0.2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                CustomCard(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionItem(
                        iconData: FontAwesomeIcons.shareNodes,
                        label: TranslationsKeys.tkShareLabel,
                        onTap: _share,
                      ),
                      Container(width: 2, height: 24.0, color: ColorManager.primaryColor),
                      ActionItem(
                        iconData: FontAwesomeIcons.camera,
                        label: TranslationsKeys.tkScreenshotLabel,
                        onTap: _screenshot,
                      ),
                      Container(width: 2, height: 24.0, color: ColorManager.primaryColor),
                      ActionItem(
                        iconData: FontAwesomeIcons.check,
                        label: TranslationsKeys.tkDoneLabel,
                        onTap: _done,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _done() {
    BankServicesActions.instance.done();
  }

  Future<void> _share() async {
    Uint8List? image = await screenshotController.capture();
    BankServicesActions.instance.share(image);
  }

  Future<void> _screenshot() async {
    Uint8List? image = await screenshotController.capture();
    BankServicesActions.instance.screenshot(image);
  }

}

class ActionItem extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String label;

  const ActionItem({super.key, required this.iconData, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          FaIcon(
            iconData,
            size: 20,
          ),
          SizedBox(width: 4.0),
          CustomText.title(label, fontSize: 14),
        ],
      ),
    );
  }
}



