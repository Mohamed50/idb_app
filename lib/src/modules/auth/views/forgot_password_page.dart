import 'package:az_banking_app/src/utils/screen_utils.dart';
import 'package:az_banking_app/src/views/custom/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/config/config.dart';
import '/src/utils/validator.dart';
import '/src/views/custom/customs.dart';
import '/src/modules/auth/auth.dart';

class ForgotPasswordPage extends GetWidget<AuthViewModel> {
  static final _formKey = GlobalKey<FormState>();
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtils.getScreenHeight(context) - 64,
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsManager.logoPath,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.contain,
                ),
                const CustomText(TranslationsKeys.tkPasswordResetWelcomeMsg),
                SizedBox(height: 32.0),
                CustomFormField(
                  label: TranslationsKeys.tkUsernameLabel,
                  onSaved: (value) => controller.username = value,
                  validator: InputsValidator.usernameValidator,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                ),
                SizedBox(height: 24.0),
                CustomButton(
                  text: TranslationsKeys.tkForgetPasswordLabel,
                  onPressed: _forgotPassword,
                ),
                Spacer(),
                TextDivider(TranslationsKeys.tkOrLabel, height: 64.0,),
                Spacer(),
                CustomButton.negative(
                  text: TranslationsKeys.tkContactCustomerServiceBtn,
                  onPressed: _toCustomService,
                ),
                Spacer(),
                TextButton(
                  onPressed: _toLoginPage,
                  child: const CustomText.underline(
                    TranslationsKeys.tkBackToLogin,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _forgotPassword() {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthActions.instance.toSecurityQuestionsPage();
    }
  }

  void _toLoginPage() {
    AuthActions.instance.back();
  }

  void _toCustomService() {
    AuthActions.instance.toCustomService();
  }
}
