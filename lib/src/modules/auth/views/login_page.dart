import 'package:az_banking_app/src/modules/auth/views/widgets/info_page_item.dart';
import 'package:az_banking_app/src/modules/home/actions/home_actions.dart';
import 'package:az_banking_app/src/modules/locale/views/language_button.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '/src/views/custom/customs.dart';
import '/src/config/config.dart';
import '/src/modules/auth/auth.dart';

class LoginPage extends GetWidget<AuthViewModel> {
  static final _formKey = GlobalKey<FormState>();

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          height: ScreenUtils.getScreenHeight(context),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                CustomCard(
                  padding: EdgeInsets.all(12.0),
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  child: Image.asset(
                    AssetsManager.logoPath,
                    height: MediaQuery.of(context).size.height / 6,
                    fit: BoxFit.contain,
                  ),
                ),
                Spacer(),
                CustomCard(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const CustomText(TranslationsKeys.tkLoginWelcomeMsg),
                      SizedBox(height: 32.0),
                      CustomFormField(
                        label: TranslationsKeys.tkUsernameLabel,
                        initialValue: controller.userId,
                        onSaved: (value) => controller.username = value,
                        validator: InputsValidator.usernameValidator,
                        maxLines: 1,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 12.0),
                      PasswordFormField(
                        label: TranslationsKeys.tkPasswordLabel,
                        onSaved: (value) => controller.password = value,
                        validator: InputsValidator.passwordRequiredOnlyValidator,
                        textInputAction: TextInputAction.go,
                      ),
                      TextButton(
                        onPressed: _toPasswordPage,
                        child: const CustomText.underline(
                          TranslationsKeys.tkForgetPasswordLabel,
                        ),
                      ),
                      SizedBox(height: 32.0),
                      CustomButton(text: TranslationsKeys.tkSignInBtn, onPressed: () => _login(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const CustomText(TranslationsKeys.tkNoAccountLabel),
                          TextButton(
                            onPressed: _toRegisterPage,
                            child: const CustomText.underline(TranslationsKeys.tkRegisterNowLabel),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InfoPageItem(
                      onTap: _toAboutUsPage,
                      iconData: FontAwesomeIcons.circleInfo,
                      label: TranslationsKeys.tkAboutUsLabel,
                    ),
                    InfoPageItem(
                      onTap: _toBranchesPage,
                      iconData: FontAwesomeIcons.buildingColumns,
                      label: TranslationsKeys.tkBranchesLabel,
                    ),
                    InfoPageItem(
                      onTap: _toContactUsPage,
                      iconData: FontAwesomeIcons.phone,
                      label: TranslationsKeys.tkContactUsLabel,
                    ),
                    InfoPageItem(
                      onTap: _toWebsitePage,
                      iconData: FontAwesomeIcons.windowRestore,
                      label: TranslationsKeys.tkWebsiteLabel,
                    ),
                  ],
                ),
                Spacer(),
                LanguageButton(),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthActions.instance.signIn(context);
    }
  }

  void _toRegisterPage() {
    AuthActions.instance.toRegisterPage();
  }

  void _toPasswordPage() {
    AuthActions.instance.toPasswordResetPage();
  }

  void _toAboutUsPage() {
    HomeActions.instance.toAboutUsPage();
  }

  void _toBranchesPage() {
    HomeActions.instance.toBranchesPage();
  }

  void _toContactUsPage() {
    HomeActions.instance.toContactUsPage();
  }

  void _toWebsitePage() {
    HomeActions.instance.toWebsitePage();
  }
}
