import 'package:az_banking_app/src/essentials/services/memory_service.dart';
import 'package:az_banking_app/src/modules/auth/data/models/question_model.dart';
import '/src/essentials/config/api_config.dart';
import '/src/essentials/services/api_service.dart';

/// The `AuthService` class is responsible for handling all authentication-related
/// operations, such as signing in, signing out, and managing access and refresh tokens.
/// It interacts with the API to authenticate users and saves the tokens in memory for
/// session management. The class also provides methods to check whether the tokens are
/// expired and ensures the user session is maintained. It extends `ApiService` to
/// leverage HTTP request functionalities.
class PasswordService extends ApiService {
  // fetches user questions.
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    final body = {"Password": generateMd5(oldPassword), "New_Password": generateMd5(newPassword)};
    await post(APIConfiguration.changePasswordUrl, body);
    return true;
  }

  // fetches user questions.
  Future<bool> forgotPassword(String newPassword) async {
    final body = {'User_ID': userId, 'New_Password': generateMd5(newPassword)};
    await post(APIConfiguration.forgetPassword, body);
    return true;
  }

  // fetches user questions.
  Future<List<QuestionModel>> fetchSecurityQuestions() async {
    final response = await post(
      APIConfiguration.securityQuestionsUrl,
      headers: getUnauthorizedHeader(), // Uses header without authorization
      {},
    );
    return questionModelFromJson(response.body['Questions_List']);
  }

  // submit user questions with answers.
  Future<bool> submitSecurityQuestions(List<QuestionModel> questions) async {
    final body = {
      'User_ID': userId,
      'Questions_List': questions.map((e) => e.toJson()).toList(),
    };
    final response = await post(APIConfiguration.submitSecurityQuestionsUrl, body);
    MemoryService.instance.accessToken = response.headers!['authorization']!.replaceFirst('Bearer ', ''); // Save access token
    return true;
  }

  // submit user questions with answers.
  Future<bool> changeSecurityQuestions(List<QuestionModel> questions) async {
    final body = {
      'User_ID': userId,
      'Questions_List': questions.map((e) => e.toJson()).toList(),
    };
    final response = await post(APIConfiguration.changeSecurityQuestionsUrl, body);
    MemoryService.instance.accessToken = response.headers!['authorization']!.replaceFirst('Bearer ', ''); // Save access token
    return true;
  }
}
