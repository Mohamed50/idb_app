import 'package:az_banking_app/src/modules/auth/controllers/forgot_password_view_model.dart';
import 'package:az_banking_app/src/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/config/config.dart';
import '/src/utils/validator.dart';
import '/src/views/custom/customs.dart';
import '/src/modules/auth/auth.dart';

class ResetPasswordPage extends GetWidget<AuthViewModel> {
  static final _formKey = GlobalKey<FormState>();
  const ResetPasswordPage({super.key});

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
                CustomText(TranslationsKeys.tkResetPasswordWelcomeMsg),
                SizedBox(height: 32.0),
                CustomFormField(
                  initialValue: controller.password,
                  label: TranslationsKeys.tkPasswordLabel,
                  maxLines: 1,
                  onSaved: Get.find<ForgotPasswordViewModel>().onNewPasswordChanged,
                  validator: InputsValidator.passwordRequiredOnlyValidator,
                ),
                SizedBox(height: 24.0),
                CustomButton(
                  text: TranslationsKeys.tkConfirmBtn,
                  onPressed: () => resetPassword(context),
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

  void resetPassword(BuildContext context) {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthActions.instance.resetPassword(context);
    }
  }

  void _toLoginPage() {
    AuthActions.instance.back();
  }
}
