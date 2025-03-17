import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/actions/account_actions.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/bank_services/views/bank_card_design.dart';
import 'package:az_banking_app/src/views/custom/custom_container.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountItemCard extends StatelessWidget {
  final AccountModel accountModel;
  final bool selected;

  const AccountItemCard({super.key, required this.accountModel, this.selected = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: ColorManager.buttonGradient,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomCard(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      AssetsManager.icMoneyPath,
                      width: 32,
                      height: 32,
                      color: ColorManager.primaryColor,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText.subtitle(
                          TranslationsKeys.tkBalanceLabel,
                          color: Colors.white,
                        ),
                        CustomText.title(
                          '${accountModel.balance} ',
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: CustomCard(
            borderRadius: BorderRadius.only(topRight: Radius.circular(12.0)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: _toQrCodePage,
                  child: CustomCard(
                    color: ColorManager.primaryColor.withValues(alpha: 0.2),
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.qr_code_2_rounded,
                      color: ColorManager.primaryColor,
                      size: 40.0,
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                InkWell(
                  onTap: _toQrCodePage,
                  child: CustomCard(
                    color: ColorManager.primaryColor.withValues(alpha: 0.2),
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.copy,
                      color: ColorManager.primaryColor,
                      size: 40.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _copyAccountToClipboard() {
    AccountActions.instance.copyToClipboard(accountModel);
  }

  void _toQrCodePage() {
    AccountActions.instance.toQrCodePage(accountModel);
  }
}
