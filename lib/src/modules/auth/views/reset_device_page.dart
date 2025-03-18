import 'package:az_banking_app/src/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
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
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtils.getScreenHeight(context) - 64,
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                CustomCard(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(TranslationsKeys.tkResetDeviceWelcomeMsg),
                      SizedBox(height: 24.0),
                      CustomText.subtitle(TranslationsKeys.tkPhoneLabel),
                      CustomText.title(controller.user!.phoneNo),
                      SizedBox(height: 24.0),
                      OtpTextField(
                        numberOfFields: 6,
                        borderColor: ColorManager.primaryColor,
                        disabledBorderColor: ColorManager.primaryColor,
                        enabledBorderColor: ColorManager.darkBackgroundColor,
                        focusedBorderColor: ColorManager.primaryColor,
                        borderWidth: 32,
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {
                          controller.otp = code;
                        },
                        onSubmit: (String verificationCode){
                          controller.otp = verificationCode;
                          resetDevice(context);
                        }, // end onSubmit
                      ),
                      SizedBox(height: 24.0),
                      CustomButton(
                        text: TranslationsKeys.tkResetDeviceBtn,
                        onPressed: () => resetDevice(context),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: _toLoginPage,
                  child: const CustomText.underline(
                    TranslationsKeys.tkBackToLogin,
                    fontSize: 14.0,
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
