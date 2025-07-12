import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/actions/account_actions.dart';
import 'package:az_banking_app/src/modules/accounts/controllers/account_view_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_drop_down.dart';
import 'package:az_banking_app/src/modules/bank_services/views/transfer_services_grid.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PrimaryAccountWidget extends StatelessWidget {
  const PrimaryAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: ColorManager.cardGradient,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: Icon(Icons.menu, color: Colors.white),
                        ),
                        SizedBox(width: 8.0),
                        CustomText.title(TranslationsKeys.tkMyAccountsLabel, color: Colors.white),
                        SizedBox(width: 4),
                        GetBuilder<AccountViewModel>(
                          builder: (controller) => CustomText.subtitle('(${controller.accounts.data?.length})', color: Colors.white),
                        ),
                        Expanded(
                          child: GetBuilder<AccountViewModel>(
                            builder: (controller) => CustomVisible(
                              show: (controller.accounts.data?.length ?? 0) > 0,
                              child: HomeAccountsDropDown(
                                onChanged: controller.onSelectedAccountChange,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        InkWell(
                            onTap: _toQrDialog,
                            child: Image.asset(AssetsManager.icQRPath, width: 24.0, color: Colors.white,)),
                      ],
                    ),
                    SizedBox(height: 24.0),
                    GetBuilder<AccountViewModel>(
                      builder: (controller) => controller.primaryAccount != null
                          ? ApiHandler(
                              apiResponse: controller.accounts, onSuccess: _AccountInfoWidget(accountModel: controller.primaryAccount!))
                          : Container(),
                    ),
                    SizedBox(height: 12.0),
                  ],
                ),
              ),
              TransferServicesWidget(),
              SizedBox(height: 24.0)
            ],
          ),
        ),
      ],
    );
  }

  void _toQrDialog() {
    AccountActions.instance.toQrCodePage(Get.find<AccountViewModel>().selectedAccount);
  }
}

class _AccountInfoWidget extends StatelessWidget {
  final AccountModel accountModel;

  const _AccountInfoWidget({required this.accountModel});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(12.0),
      width: double.infinity,
      color: ColorManager.lightBackgroundColor.withValues(alpha: 0.0),
      borderRadius: BorderRadius.circular(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText.title(
            accountModel.balance,
            color: Colors.white,
            fontSize: 28.0,
          ),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomText.subtitle(
                    TranslationsKeys.tkIbanLabel,
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  CustomText.title(
                    accountModel.iban,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ],
              ),
              Column(
                children: [
                  CustomText.subtitle(
                    TranslationsKeys.tkAccountNoLabel,
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  CustomText.title(
                    '${accountModel.accountNo} ',
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
