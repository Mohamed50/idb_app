import 'package:az_banking_app/src/modules/auth/controllers/change_security_questions_view_model.dart';
import 'package:az_banking_app/src/modules/auth/data/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/config/config.dart';
import '/src/views/custom/customs.dart';
import '/src/modules/auth/auth.dart';

class ChangeSecurityQuestionsPage extends GetWidget<ChangeSecurityQuestionViewModel> {
  static final _formKey = GlobalKey<FormState>();

  const ChangeSecurityQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: TranslationsKeys.tkChangeSecurityQuestionsLabel,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const CustomText(TranslationsKeys.tkChangeSecurityQuestionsWelcomeMsg),
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
    );
  }

  void submitAnswers(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthActions.instance.changeSecurityQuestionsAnswers(context);
    }
  }
}

class _OnSuccess extends StatelessWidget {
  final List<QuestionModel> questions;

  const _OnSuccess({required this.questions});

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
      title: CustomText.subtitle(
        questionModel.question,
        color: ColorManager.titleColor,
      ),
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
