import 'dart:math';

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
    return BankCardBackground(
      cardDesign: CardDesign.two,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
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
                InkWell(
                  onTap: _toQrCodePage,
                  child: CustomCard(
                    color: ColorManager.lightBackgroundColor.withValues(alpha: 0.2),
                    width: 40.0,
                    height: 40.0,
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: Icon(Icons.qr_code_2_rounded, color: Colors.white,size: 30.0,),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                InkWell(
                  onTap: _copyAccountToClipboard,
                  child: CustomCard(
                    color: ColorManager.lightBackgroundColor.withValues(alpha: 0.2),
                    width: 40.0,
                    height: 40.0,
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.copy,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _copyAccountToClipboard() {
    AccountActions.instance.copyToClipboard(accountModel);
  }

  void _toQrCodePage() {
    AccountActions.instance.toQrCodePage(accountModel);
  }
}
