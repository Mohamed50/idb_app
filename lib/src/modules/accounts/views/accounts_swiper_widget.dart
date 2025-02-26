import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/controllers/account_view_model.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';

import 'account_tile.dart';

class AccountsSwiperWidget extends StatelessWidget {
  final ValueChanged<AccountModel>? onChanged;

  const AccountsSwiperWidget({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountViewModel>(
      builder: (controller) => ApiHandler(
        apiResponse: controller.accounts,
        onSuccess: _OnSuccess(
          accounts: controller.accounts.data ?? [],
          selectedAccount: controller.primaryAccount,
          onChanged: onChanged,
          selectedIndex: controller.selectedIndex,
        ),
      ),
    );
  }
}

class _OnSuccess extends StatelessWidget {
  final ValueChanged<AccountModel>? onChanged;
  final List<AccountModel> accounts;
  final AccountModel? selectedAccount;
  final int selectedIndex;

  const _OnSuccess({required this.accounts, required this.selectedAccount, this.onChanged, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: FlutterCarouselOptions(
        initialPage: selectedIndex,
        slideIndicator: CircularWaveSlideIndicator(
          slideIndicatorOptions: SlideIndicatorOptions(
            currentIndicatorColor: ColorManager.primaryColor,
            indicatorBackgroundColor: ColorManager.primaryColor.withValues(alpha: 0.3),
            padding: EdgeInsets.all(12.0),
          ),
        ),
        showIndicator: true,
        aspectRatio: 1.6,
        enlargeCenterPage: true,
        floatingIndicator: false,
        onPageChanged: (index, reason){
          Get.find<AccountViewModel>().onSelectedIndexChange(index);
          if(onChanged != null){
            onChanged!(accounts[index]);
          }
        },
      ),
      items: accounts.map((account) {
        return Builder(
          builder: (BuildContext context) {
            return AccountItemCard(
              accountModel: account,
              selected: account.accountNo == selectedAccount?.accountNo,
            );
          },
        );
      }).toList(),
    );
  }
}