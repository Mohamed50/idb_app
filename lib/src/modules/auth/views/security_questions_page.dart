import 'package:az_banking_app/src/modules/auth/controllers/forgot_password_view_model.dart';
import 'package:az_banking_app/src/modules/auth/data/models/question_model.dart';
import 'package:az_banking_app/src/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/config/config.dart';
import '/src/views/custom/customs.dart';
import '/src/modules/auth/auth.dart';

class SecurityQuestionsPage extends GetWidget<ForgotPasswordViewModel> {
  static final _formKey = GlobalKey<FormState>();

  const SecurityQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkBackgroundColor,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            Image.asset(
              AssetsManager.logoPath,
              fit: BoxFit.contain,
              height: ScreenUtils.getScreenHeight(context) / 4,
            ),
            SizedBox(height: 32.0),
            CustomCard(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Center(child: const CustomText(TranslationsKeys.tkSecurityQuestionsWelcomeMsg)),
                  Obx(
                    () => ApiHandler(
                      apiResponse: controller.securityQuestions,
                      onSuccess: _OnSuccess(questions: controller.securityQuestions.data ?? []),
                    ),
                  ),
                  CustomButton(
                    text: TranslationsKeys.tkConfirmBtn,
                    onPressed: () => submitAnswers(context),
                  ),
                ],
              ),
            ),
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
    );
  }

  void submitAnswers(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthActions.instance.submitSecurityQuestionsAnswers(context);
    }
  }

  void _toLoginPage() {
    AuthActions.instance.back();
  }
}

class _OnSuccess extends StatelessWidget {
  final List<QuestionModel> questions;

  const _OnSuccess({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 24.0),
      itemCount: questions.length,
      itemBuilder: (context, index) => QuestionTile(questionModel: questions[index]),
      separatorBuilder: (context, index) => SizedBox(height: 12.0),
    );
  }
}

class QuestionTile extends StatelessWidget {
  final QuestionModel questionModel;

  const QuestionTile({super.key, required this.questionModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomText.subtitle(questionModel.question, color: ColorManager.titleColor,),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomFormField(
          label: TranslationsKeys.tkAnswerLabel,
          onSaved: (value) => questionModel.answer = value ?? '',
          // validator: InputsValidator.answerValidator,
        ),
      ),
    );
  }
}
