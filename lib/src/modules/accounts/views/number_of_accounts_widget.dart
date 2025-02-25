import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/actions/account_actions.dart';
import 'package:az_banking_app/src/modules/accounts/controllers/account_view_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NumberOfAccountsWidget extends StatelessWidget {
  const NumberOfAccountsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<AccountViewModel>(
      builder: (controller) => ApiHandler(
        apiResponse: controller.accounts,
        onSuccess: _OnSuccess(accounts: controller.accounts.data ?? []),
      ),
    );
  }
}

class _OnSuccess extends StatelessWidget {
  final List<AccountModel> accounts;

  const _OnSuccess({required this.accounts});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toAccountPage,
      child: CustomCard(
        color: ColorManager.darkBackgroundColor,
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCard(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                AssetsManager.icAccountsPath,
                width: 40,
                height: 40,
              ),
            ),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.subtitle(
                  TranslationsKeys.tkLinkedAccounts,
                  fontSize: 14,
                ),
                CustomText.title(
                  accounts.length.toString(),
                  fontSize: 24,
                ),
              ],
            ),
            Spacer(),
            Icon(CupertinoIcons.forward)
          ],
        ),
      ),
    );
  }

  void _toAccountPage() {
    AccountActions.instance.toAccountsPage();
  }
}

