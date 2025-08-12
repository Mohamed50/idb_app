import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/controllers/link_account_view_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/auth/auth.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LinkAccountsPage extends StatelessWidget {
  const LinkAccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Image.asset(
              AssetsManager.logoPath,
              height: MediaQuery.of(context).size.height / 3,
              fit: BoxFit.contain,
            ),
            const CustomText(TranslationsKeys.tkLinkAccountsDescription),
            Expanded(
              child: GetBuilder<LinkAccountViewModel>(
                builder:(controller) => ApiHandler(
                  apiResponse: controller.accounts,
                  onSuccess: _OnSuccess(
                    accounts: controller.accounts.data ?? [],
                    onSelectAccount: controller.onSelectAccount,
                    isSelected: controller.isSelected,
                  ),
                ),
              ),
            ),
            CustomButton(
              text: TranslationsKeys.tkConfirmBtn,
              onPressed: () => _confirm(context),
            )
          ],
        ),
      ),
    );
  }

  void _confirm(BuildContext context) {
    AuthActions.instance.linkAccounts(context);
  }
}

class _OnSuccess extends StatelessWidget {
  final List<AccountModel> accounts;
  final ValueChanged<AccountModel> onSelectAccount;
  final bool Function(AccountModel value) isSelected;

  const _OnSuccess({required this.accounts, required this.onSelectAccount, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: accounts.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => onSelectAccount(accounts[index]),
        child: AccountItemTile(
          backgroundColor:
              isSelected(accounts[index]) ? ColorManager.primaryColor.withValues(alpha: 0.9) : ColorManager.darkBackgroundColor,
          selected: isSelected(accounts[index]),
          accountModel: accounts[index],
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 12),
    );
  }
}

class AccountItemTile extends StatelessWidget {
  final AccountModel accountModel;
  final bool selected;
  final Color backgroundColor;
  final bool withName;

  const AccountItemTile({
    super.key,
    required this.accountModel,
    this.selected = true,
    this.backgroundColor = ColorManager.darkBackgroundColor,
    this.withName = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.subtitle(
            TranslationsKeys.tkIbanLabel,
            fontSize: 10,
            color: selected ? Colors.white : null,
          ),
          CustomText.title(
            accountModel.iban,
            fontSize: 14,
            color: selected ? Colors.white : null,
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
                    color: selected ? Colors.white : null,
                  ),
                  CustomText.title(
                    accountModel.accountNo,
                    fontSize: 14,
                    color: selected ? Colors.white : null,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.subtitle(
                    TranslationsKeys.tkAccountTypeLabel,
                    fontSize: 10,
                    color: selected ? Colors.white : null,
                  ),
                  CustomText.title(
                    accountModel.accountType.name.toUpperCase(),
                    fontSize: 14,
                    color: selected ? Colors.white : null,
                  ),
                ],
              ),
            ],
          ),
          CustomVisible(
            show: withName && accountModel.name.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.subtitle(
                    TranslationsKeys.tkReceiverNameLabel,
                    fontSize: 10,
                  ),
                  CustomText.title(
                    accountModel.name,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          CustomVisible(
            show: withName && accountModel.name.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.subtitle(
                    TranslationsKeys.tkPhoneLabel,
                    fontSize: 10,
                  ),
                  CustomText.title(
                    accountModel.phone,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
