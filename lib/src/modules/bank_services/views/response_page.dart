import 'dart:typed_data';
import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_list.dart';
import 'package:az_banking_app/src/modules/bank_services/actions/bank_service_actions.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/service_config.dart';
import 'package:az_banking_app/src/views/custom/custom_button.dart';
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
    final Map<String, dynamic> response = Get.arguments['response'];
    final AccountModel? toAccount = Get.arguments['to_account'];
    final children = ServicesConfiguration.getServiceResponseItems(response);
    return Scaffold(
      backgroundColor: ColorManager.lightBackgroundColor,
      body: SafeArea(
        child: Screenshot(
          controller: screenshotController,
          child: Container(
            color: ColorManager.lightBackgroundColor,
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 52.0),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        CustomCard(
                          color: ColorManager.darkBackgroundColor,
                          child: Column(
                            children: [
                              SizedBox(height: 52 + 24),
                              CustomText.subtitle(
                                TranslationsKeys.tkTransactionInfoLabel,
                                color: ColorManager.titleColor,
                              ),
                              ListView.separated(
                                padding: EdgeInsets.all(12.0),
                                shrinkWrap: true,
                                itemCount: children.length,
                                itemBuilder: (context, index) => children[index],
                                separatorBuilder: (context, index) => Divider(
                                  color: ColorManager.titleColor,
                                  thickness: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        toAccount != null
                            ? Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: AccountItemTile(
                            accountModel: toAccount,
                            withName: true,
                          ),
                        )
                            : Container()
                      ],
                    ),
                    Positioned(
                      top: -52,
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.lightBackgroundColor,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorManager.positiveColor.withValues(alpha: 0.08),
                              border: Border.all(color: ColorManager.positiveColor)),
                          padding: EdgeInsets.all(24.0),
                          child: FaIcon(
                            FontAwesomeIcons.check,
                            size: 80 - 24,
                            color: ColorManager.positiveColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                CustomButton.muted(text: TranslationsKeys.tkShareLabel, onPressed: _share),
                SizedBox(height: 12),
                CustomButton(text: TranslationsKeys.tkDoneLabel, onPressed: _done),
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
