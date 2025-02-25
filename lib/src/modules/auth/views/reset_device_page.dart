import 'package:az_banking_app/src/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/config/config.dart';
import '/src/utils/validator.dart';
import '/src/views/custom/customs.dart';
import '/src/modules/auth/auth.dart';

class ResetDevicePage extends GetWidget<AuthViewModel> {
  static final _formKey = GlobalKey<FormState>();
  const ResetDevicePage({super.key});

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
                CustomText(TranslationsKeys.tkResetDeviceWelcomeMsg),
                SizedBox(height: 32.0),
                CustomFormField(
                  initialValue: controller.user!.phoneNo,
                  enabled: false,
                  label: TranslationsKeys.tkPhoneLabel,
                  maxLines: 1,
                ),
                SizedBox(height: 12.0),
                CustomFormField(
                  label: TranslationsKeys.tkOtpLabel,
                  onSaved: (value) => controller.otp = value,
                  validator: InputsValidator.otpValidator,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                ),
                SizedBox(height: 24.0),
                CustomButton(
                  text: TranslationsKeys.tkResetDeviceBtn,
                  onPressed: () => resetDevice(context),
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

  void resetDevice(BuildContext context) {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthActions.instance.resetDevice(context);
    }
  }

  void _toLoginPage() {
    AuthActions.instance.back();
  }
}
