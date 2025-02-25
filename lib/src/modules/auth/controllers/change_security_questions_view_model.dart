import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/auth/data/models/question_model.dart';
import 'package:az_banking_app/src/modules/auth/data/services/password_service.dart';
import 'package:get/get.dart';

/// ViewModel responsible for managing authentication logic using GetX.
class ChangeSecurityQuestionViewModel extends GetxController {
  /// Instance of `AuthService` to perform authentication-related operations.
  final PasswordService _passwordService;

  final Rx<ApiResponse<List<QuestionModel>>> _securityQuestions = ApiResponse<List<QuestionModel>>.idle().obs;

  ApiResponse<List<QuestionModel>> get securityQuestions => _securityQuestions.value;

  /// Constructor initializes with the `AuthService` and checks the session on creation.
  ChangeSecurityQuestionViewModel(this._passwordService) {
    initialize();
  }

  void initialize() {
    _fetchSecurityQuestions();
  }

  void _fetchSecurityQuestions() {
    apiFetch(_passwordService.fetchSecurityQuestions()).listen((value) => _securityQuestions.value = value);
  }

  Future changeSecurityQuestionsAnswers() async {
    await _passwordService.changeSecurityQuestions(securityQuestions.data!);
  }
}
