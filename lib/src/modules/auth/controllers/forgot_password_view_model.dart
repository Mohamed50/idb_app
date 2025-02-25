import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/auth/data/models/question_model.dart';
import 'package:az_banking_app/src/modules/auth/data/services/password_service.dart';
import 'package:get/get.dart';

/// ViewModel responsible for managing authentication logic using GetX.
class ForgotPasswordViewModel extends GetxController {
  final String username;
  /// Instance of `AuthService` to perform authentication-related operations.
  final PasswordService _passwordService;

  String? _newPassword;

  final Rx<ApiResponse<List<QuestionModel>>> _securityQuestions = ApiResponse<List<QuestionModel>>.idle().obs;
  ApiResponse<List<QuestionModel>> get securityQuestions => _securityQuestions.value;


  /// Constructor initializes with the `AuthService` and checks the session on creation.
  ForgotPasswordViewModel(this._passwordService, this.username) {
    initialize();
  }

  void initialize(){
    _fetchSecurityQuestions();
  }

  /// Performs user sign-in with the provided username and password.
  void _fetchSecurityQuestions() {
    apiFetch(_passwordService.fetchSecurityQuestions()).listen((value) => _securityQuestions.value = value);
  }

  Future submitSecurityQuestionsAnswers() async{
    await _passwordService.submitSecurityQuestions(securityQuestions.data!);
  }

  Future resetPassword() async {
    await _passwordService.forgotPassword(_newPassword!);
  }


  void onNewPasswordChanged(String? newValue) {
    _newPassword = newValue;
  }
}
