import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/controllers/account_view_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountsList extends StatelessWidget {
  const AccountsList({super.key});

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
    return ListView.separated(
      shrinkWrap: true,
      itemCount: accounts.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => AccountItemTile(accountModel: accounts[index]),
      separatorBuilder: (context, index) => SizedBox(height: 12),
    );
  }
}

class AccountItemTile extends StatelessWidget {
  final AccountModel accountModel;
  final bool selected;
  final Color backgroundColor;

  const AccountItemTile({super.key, required this.accountModel, this.selected = true, this.backgroundColor = ColorManager.darkBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.subtitle(
            TranslationsKeys.tkIbanLabel,
            fontSize: 10,
          ),
          CustomText.title(
            accountModel.iban,
            fontSize: 14,
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.subtitle(
                    TranslationsKeys.tkAccountNoLabel,
                    fontSize: 10,
                  ),
                  CustomText.title(
                    accountModel.accountNo,
                    fontSize: 14,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.subtitle(
                    TranslationsKeys.tkAccountTypeLabel,
                    fontSize: 10,
                  ),
                  CustomText.title(
                    accountModel.accountType.name.toUpperCase(),
                    fontSize: 14,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

}
