import 'dart:convert';
import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/auth/data/models/user.dart';
import 'package:az_banking_app/src/utils/utils.dart';
import 'package:get/get.dart';
import '/src/essentials/services/memory_service.dart';
import '/src/essentials/config/api_config.dart';
import '/src/essentials/services/api_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// The `AuthService` class is responsible for handling all authentication-related
/// operations, such as signing in, signing out, and managing access and refresh tokens.
/// It interacts with the API to authenticate users and saves the tokens in memory for
/// session management. The class also provides methods to check whether the tokens are
/// expired and ensures the user session is maintained. It extends `ApiService` to
/// leverage HTTP request functionalities.
class AuthService extends ApiService {
  // Handles user sign-in by sending credentials (email, password) to the API.
  // Stores the access and refresh tokens in MemoryService upon successful login.
  Future<UserModel> signIn(String username, String password) async {
    final deviceInfo = await Utils.getDeviceInfo();
    final body = {
      'User_ID': username,
      'Password': generateMd5(password),
      'Channel_ID': 1,
      'App_Version_Code': 3,
      'App_Name': 'JB',
      'Device_Info': [deviceInfo],
      'Device_Key': deviceInfo['Device_ID']
    };
    Response response = await post(
      APIConfiguration.signInUrl,
      body,
    );
    bool deviceNeedReset = response.body['Response_Code'] == 2;
    String token = response.headers!['authorization']!.replaceFirst('Bearer ', '');
    if(!deviceNeedReset){
      MemoryService.instance.accessToken = token; // Save access token
    }
    final tokenInfo = JwtDecoder.decode(token);
    MemoryService.instance.userId = tokenInfo['UserID'];
    response.body['Customer_Info']['Device_ID'] = tokenInfo['DeviceKey'];
    response.body['Customer_Info']['reset_device'] = response.body['Response_Code'] == 2;
    UserModel userModel = UserModel.fromJson(response.body['Customer_Info']);
    userModel.token = token;
    // UserModel userModel = UserModel(customerName: '', imageUri: '', phoneNo: '', deviceId: '', isResetDeviceRequired: false);
    MemoryService.instance.user = json.encode(userModel.toJson());
    return userModel;
  }

  // Handles user sign-up by user information to the API.
  // return true upon successful sign up.
  Future<bool> signUp(String nationalNumber, String rim, String phoneNumber) async {
    if(phoneNumber[0] == '0'){
      phoneNumber = phoneNumber.substring(1);
    }
    final body = {'RIM': rim, 'Phone_No': '249$phoneNumber', 'National_ID': nationalNumber};
    await post(
      APIConfiguration.signUpUrl,
      headers: getUnauthorizedHeader(), // Uses header without authorization
      body,
    );
    return true;
  }


  // final step of registration after validating user information and mobile number .
  // return user id upon successful registration.
  Future<String> registerAccount(
      String nationalNumber,
      String rim,
      String phoneNumber,
      String nameEn,
      String nameAr,
      AccountModel primaryAccount,
      ) async {
    if (phoneNumber[0] == '0') {
      phoneNumber = phoneNumber.substring(1);
    }
    final body = {
      'RIM': rim,
      'Phone_No': '249$phoneNumber',
      'National_ID': nationalNumber,
      'Customer_Name_EN': nameEn,
      'Customer_Name_AR': nameAr,
      'Account_No': primaryAccount.accountNo,
      'Email': 'N/A',
      'Address': 'N/A',
    };
    final response = await post(
      APIConfiguration.registerUrl,
      headers: getUnauthorizedHeader(), // Uses header without authorization
      body,
    );
    return response.body['User_ID'];
  }

  // Handles user sign-out by clearing tokens and selected venue/zone from MemoryService.
  Future<bool> signOut() async {
    MemoryService.instance.accessToken = null; // Clear access token
    MemoryService.instance.refreshToken = null; // Clear refresh token
    return true;
  }

  // fetches user questions.
  Future<bool> requestOtp(String token) async {
    await get(APIConfiguration.requestOtpUrl, headers: getDefaultHeader(token));
    return true;
  }

  // verify otp.
  Future<bool> resetDevice(String otp, String token) async {
    final deviceInfo = await Utils.getDeviceInfo();
    final body = {"OTP": otp, "New_Device_Key": deviceInfo['Device_ID']};
    await post(APIConfiguration.verifyOtpUrl, body, headers: getDefaultHeader(token));
    return true;
  }

  // verify register otp.
  Future<VerifyResponse> verifyAccountByOtp(String rim, String otp) async {
    final body = {'RIM': rim, 'OTP': otp};
    final response = await post(APIConfiguration.verifyAccountByOtpUrl, body);
    return VerifyResponse(accounts: accountModelFromJson(response.body['Accounts_List']), nameEn: response.body['Customer_Name_EN'], nameAr: response.body['Customer_Name_AR']);
  }

  // Checks if the user is logged in by verifying if an access token is present in MemoryService.
  Future<bool> isLoggedIn() async {
    String? token = MemoryService.instance.accessToken;
    return token != null; // Returns true if the token is not null
  }

  // Checks if the access token is expired by decoding and analyzing the token.
  // Throws an AppException if the token is null (no session).
  Future<bool> isAccessTokenExpired() async {
    String? token = MemoryService.instance.accessToken;
    if (token == null) {
      throw AuthException('No Session'); // Throw exception if no token found
    }
    return JwtDecoder.isExpired(token); // Use JwtDecoder to check token expiration
  }

  UserModel? fetchUserFromMemory() {
    String? userJson = MemoryService.instance.user;
    if (userJson != null) {
      return UserModel.fromString(userJson);
    }
    return null;
  }


  String? fetchUserIdFromMemory() {
    return MemoryService.instance.userId;
  }


  Future<bool> linkAccounts(String userId, List<AccountModel> selectedAccounts) async {
    MemoryService.instance.userId = userId;
    final body = {'User_ID': userId, 'Accounts_List': selectedAccounts.map((e) => e.toJson()).toList()};
    await post(APIConfiguration.linkAccountsUrl, body);
    return true;
  }

  Future<bool> setPassword(String userId, String password) async {
    final body = {'User_ID': userId, 'Password': generateMd5(password)};
    await post(APIConfiguration.setAccountPasswordsUrl, body);
    return true;
  }
}


class VerifyResponse {
  final List<AccountModel> accounts;
  final String nameEn;
  final String nameAr;

  VerifyResponse({required this.accounts, required this.nameEn, required this.nameAr});

}