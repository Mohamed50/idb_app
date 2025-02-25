import 'package:az_banking_app/src/modules/auth/auth.dart';
import 'package:az_banking_app/src/modules/auth/controllers/change_password_view_model.dart';
import 'package:az_banking_app/src/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/config/config.dart';
import '/src/utils/validator.dart';
import '/src/views/custom/customs.dart';

class ChangePasswordPage extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: TranslationsKeys.tkChangePasswordLabel),
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtils.getScreenHeight(context) - 64,
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(TranslationsKeys.tkChangePasswordWelcomeMsg),
                SizedBox(height: 32.0),
                PasswordFormField(
                  label: TranslationsKeys.tkCurrentPasswordLabel,
                  maxLines: 1,
                  onSaved: Get.find<ChangePasswordViewModel>().onCurrentPasswordChanged,
                  validator: InputsValidator.passwordRequiredOnlyValidator,
                ),
                SizedBox(height: 12.0),
                PasswordFormField(
                  label: TranslationsKeys.tkNewPasswordLabel,
                  maxLines: 1,
                  onSaved: Get.find<ChangePasswordViewModel>().onNewPasswordChanged,
                  validator: InputsValidator.passwordRequiredOnlyValidator,
                ),
                SizedBox(height: 12.0),
                PasswordFormField(
                  label: TranslationsKeys.tkConfirmNewPasswordLabel,
                  maxLines: 1,
                  onSaved: Get.find<ChangePasswordViewModel>().onConfirmNewPasswordChanged,
                  validator: InputsValidator.passwordRequiredOnlyValidator,
                ),
                SizedBox(height: 32.0),
                CustomButton(
                  text: TranslationsKeys.tkConfirmBtn,
                  onPressed: () => changePassword(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changePassword(BuildContext context) {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthActions.instance.changePassword(context);
    }
  }

}
