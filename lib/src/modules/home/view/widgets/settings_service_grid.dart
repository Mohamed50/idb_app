import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/home/actions/settings_actions.dart';
import 'package:az_banking_app/src/modules/home/home.dart';
import 'package:az_banking_app/src/modules/locale/controllers/localization_view_model.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsServiceGrid extends StatelessWidget {
  const SettingsServiceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1.2,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SettingsItem(
          label: TranslationsKeys.tkChangePasswordLabel,
          iconPath: AssetsManager.icChangePasswordPath,
          onTap: _toChangePasswordPage,
        ),
        SettingsItem(
          label: TranslationsKeys.tkSecurityQuestionsLabel,
          iconPath: AssetsManager.icSecurityQuestionsPath,
          onTap: _toSecurityQuestionsPage,
        ),
        SettingsItem(
          label: TranslationsKeys.tkFaqsLabel,
          iconPath: AssetsManager.icFaqPath,
          onTap: _toFaqsPage,
        ),
        SettingsItem(
          label: TranslationsKeys.tkTransactionLimitLabel,
          iconPath: AssetsManager.icTransactionLimitPath,
          onTap: _toTransactionLimitPage,
        ),
        GetX<LocalizationViewModel>(
          builder: (controller) => SettingsItem(
            label: controller.language.name,
            iconPath: AssetsManager.icLanguagePath,
            onTap: _toLanguageSelectorPage,
          ),
        ),
        SettingsItem(
          label: TranslationsKeys.tkLogoutLabel,
          iconPath: AssetsManager.icLogoutPath,
          onTap: () => _logout(context),
        ),
      ],
    );
  }

  void _logout(BuildContext context) {
    SettingsActions.instance.logout(context);
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
      child: Column(
        children: [
          CustomCard(
            color: ColorManager.darkBackgroundColor,
            child: CustomCard(
              color: Colors.white,
              child: Image.asset(iconPath, width: 40, height: 40),
            ),
          ),
          SizedBox(height: 4.0),
          CustomText.title(
            label,
            fontSize: 12.0,
          ),
        ],
      ),
    );
  }
}
