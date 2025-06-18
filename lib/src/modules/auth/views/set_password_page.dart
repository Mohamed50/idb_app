import 'package:az_banking_app/src/modules/auth/auth.dart';
import 'package:az_banking_app/src/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/config/config.dart';
import '/src/utils/validator.dart';
import '/src/views/custom/customs.dart';

class SetPasswordPage extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
  const SetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtils.getScreenHeight(context) - 64,
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      const CustomText(TranslationsKeys.tkPasswordSetWelcomeMsg),
                      SizedBox(height: 24.0),
                      PasswordFormField(
                        label: TranslationsKeys.tkNewPasswordLabel,
                        maxLines: 1,
                        onSaved: Get.find<AuthViewModel>().onPasswordChange,
                        validator: InputsValidator.passwordRequiredOnlyValidator,
                      ),
                      SizedBox(height: 12.0),
                      PasswordFormField(
                        label: TranslationsKeys.tkConfirmNewPasswordLabel,
                        maxLines: 1,
                        onSaved: Get.find<AuthViewModel>().onConfirmPasswordChanged,
                        validator: InputsValidator.passwordRequiredOnlyValidator,
                      ),
                      SizedBox(height: 32.0),
                      CustomButton(
                        text: TranslationsKeys.tkConfirmBtn,
                        onPressed: () => setPassword(context),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setPassword(BuildContext context) {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthActions.instance.setPassword(context);
    }
  }

}
