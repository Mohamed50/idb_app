import 'package:az_banking_app/src/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/config/config.dart';
import '/src/utils/validator.dart';
import '/src/views/custom/customs.dart';
import '/src/modules/auth/auth.dart';

class RegisterPage extends GetWidget<AuthViewModel> {
  static final _formKey = GlobalKey<FormState>();

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtils.getScreenHeight(context) - 64,
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset(
                  AssetsManager.logoPath,
                  height: MediaQuery.of(context).size.height / 4,
                  fit: BoxFit.contain,
                ),
                Spacer(),
                CustomCard(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const CustomText(TranslationsKeys.tkRegisterWelcomeMsg),
                      SizedBox(height: 32.0),
                      CustomFormField(
                        label: TranslationsKeys.tkNationalNumberLabel,
                        onSaved: (value) => controller.nationalNumber = value,
                        validator: InputsValidator.nationalNumberValidator,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                      ),
                      SizedBox(height: 12.0),
                      CustomFormField(
                        label: TranslationsKeys.tkRimLabel,
                        onSaved: (value) => controller.rim = value,
                        validator: InputsValidator.rimValidator,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                      ),
                      SizedBox(height: 12.0),
                      CustomFormField(
                        label: TranslationsKeys.tkPhoneLabel,
                        onSaved: (value) => controller.phoneNumber = value,
                        validator: InputsValidator.phoneValidator,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        maxLines: 1,
                      ),
                      SizedBox(height: 32.0),
                      CustomButton(
                        text: TranslationsKeys.tkSignUpBtn,
                        onPressed: () => login(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const CustomText(TranslationsKeys.tkHaveAccountLabel),
                          TextButton(
                            onPressed: _toLoginPage,
                            child: const CustomText.underline(
                              TranslationsKeys.tkLoginNowLabel,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthActions.instance.signUp(context);
    }
  }

  void _toLoginPage() {
    AuthActions.instance.back();
  }
}
