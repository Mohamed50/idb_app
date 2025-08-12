import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/essentials/services/memory_service.dart';
import 'package:az_banking_app/src/modules/accounts/actions/account_actions.dart';
import 'package:az_banking_app/src/modules/auth/auth.dart';
import 'package:az_banking_app/src/modules/bank_services/views/service_icon_widget.dart';
import 'package:az_banking_app/src/modules/home/actions/settings_actions.dart';
import 'package:az_banking_app/src/modules/locale/controllers/localization_view_model.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsServiceList extends StatelessWidget {
  const SettingsServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    final divider = Divider(
      height: 24.0,
      thickness: 2,
      color: ColorManager.primaryColor.withValues(alpha: 0.08),
    );
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SettingsItem(
          label: TranslationsKeys.tkLinkAccountsLabel,
          iconPath: AssetsManager.icAccountsPath,
          onTap: _toLinkAccountPage,
        ),
        divider,
        SettingsItem(
          label: TranslationsKeys.tkChangePasswordLabel,
          iconPath: AssetsManager.icChangePasswordPath,
          onTap: _toChangePasswordPage,
        ),
        divider,
        SettingsItem(
          label: TranslationsKeys.tkSecurityQuestionsLabel,
          iconPath: AssetsManager.icSecurityQuestionsPath,
          onTap: _toSecurityQuestionsPage,
        ),
        divider,
        SettingsItem(
          label: TranslationsKeys.tkFaqsLabel,
          iconPath: AssetsManager.icFaqPath,
          onTap: _toFaqsPage,
        ),
        divider,
        SettingsItem(
          label: TranslationsKeys.tkTransactionLimitLabel,
          iconPath: AssetsManager.icTransactionLimitPath,
          onTap: _toTransactionLimitPage,
        ),
        divider,
        GetX<LocalizationViewModel>(
          builder: (controller) => SettingsItem(
            label: controller.language.name,
            iconPath: AssetsManager.icLanguagePath,
            onTap: _toLanguageSelectorPage,
          ),
        ),
        divider,
        SettingsItem(
          label: TranslationsKeys.tkLogoutLabel,
          iconPath: AssetsManager.icLogoutPath,
          onTap: () => _logout(context),
        ),
      ],
    );
  }

  void _logout(BuildContext context) {
    AuthActions.instance.signOut(context);
  }

  void _toLinkAccountPage() {
    final userId = Get.find<AuthViewModel>().userId;
    print(userId);
    AccountActions.instance.toLinkAccountsPage(userId!);
  }
  void _toChangePasswordPage() {
    SettingsActions.instance.toChangePasswordPage();
  }

  void _toSecurityQuestionsPage() {
    SettingsActions.instance.toSecurityQuestionsPage();
  }

  void _toFaqsPage() {
    SettingsActions.instance.toFaqsPage();
  }

  void _toLanguageSelectorPage() {
    SettingsActions.instance.toLanguageSelectorPage();
  }

  void _toTransactionLimitPage() {
    SettingsActions.instance.toTransactionLimitPage();
  }
}

class SettingsItem extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onTap;

  const SettingsItem({super.key, required this.label, required this.iconPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            Image.asset(iconPath, width: 32, height: 32, color: ColorManager.primaryColor),
            SizedBox(width: 8.0),
            CustomText.title(
              label,
              fontSize: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}
