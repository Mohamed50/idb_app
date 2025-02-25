import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/essentials/config/action_presenter.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/views/qr_code_dialog.dart';
import 'package:az_banking_app/src/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '/src/modules/auth/auth.dart';

class AccountActions extends ActionPresenter{
  static final AccountActions _mInstance = AccountActions._();

  static AccountActions get instance => _mInstance;

  AccountActions._();

  /// **Copies the given text to the clipboard.**
  Future<void> copyToClipboard(AccountModel account) async {
    await Clipboard.setData(ClipboardData(text: account.toCopiedContent()));
    showSuccessSnackBar(TranslationsKeys.tkInfoLabel, TranslationsKeys.tkAccountCopiedSuccessMsg);
  }

  void toAccountsPage() {
    Get.toNamed(RouteManager.accountsRoute);
  }

  void toQrCodePage(AccountModel accountModel) {
    Get.dialog(QrCodeDialog(accountModel: accountModel));
  }

}
