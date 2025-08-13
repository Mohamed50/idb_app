import 'dart:ui';

import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:get/get.dart';
import '/src/modules/auth/data/models/user.dart';
import '../auth.dart';

/// Enum representing different authentication states.
enum AuthState { checking, authenticated, notAuthenticated }

/// ViewModel responsible for managing authentication logic using GetX.
class AuthViewModel extends GetxController {
  /// Instance of `AuthService` to perform authentication-related operations.
  final AuthService _authService;

  final VoidCallback onAuthenticated;

  /// Observable authentication state.
  final Rx<AuthState> _authState = AuthState.checking.obs;

  /// Getter for the current authentication state.
  AuthState get authState => _authState.value;

  /// Stores the currently authenticated user.
  UserModel? _user;

  /// Getter for the currently authenticated user.
  UserModel? get user => _user;

  /// Stores the username and password for sign-in.
  String? username, password, confirmPassword;

  /// Stores the nationalNumber rim and phoneNumber for sign-up.
  String? nationalNumber, rim, phoneNumber, whatsappNumber;

  /// Stores the otp for verification.
  String? otp;

  /// Stores the name of the user.
  String? nameEn, nameAr;

  /// Stores the user id.
  String? userId;

  final RxBool _termsAgree = false.obs;

  String? phoneCountryCode, whatsappCountryCode;

  bool get termsAgree => _termsAgree.value;

  /// Constructor initializes with the `AuthService` and checks the session on creation.
  AuthViewModel(this._authService, {required this.onAuthenticated}) {
    checkSession();
    _fetchUserId();
  }

  // Checks if there is an active session by verifying token status.
  // Refreshes the session if the access token is expired but the refresh token is valid.
  Future<bool> checkSession() async {
    // if (await _authService.isLoggedIn()) {
    //   _fetchUser();
    //   bool isAccessTokenExpired = await _authService.isAccessTokenExpired();
    //   if (!isAccessTokenExpired) {
    //     authenticated(); // Set state to authenticated if tokens are valid
    //     update(); // Update GetX UI
    //     return true;
    //   }
    // }
    notAuthenticated();
    return false;
  }

  /// Refreshes the session by calling the refreshSession method from AuthService
  Future refreshSession() async {
    // await _authService.refreshSession();
  }

  /// Performs user sign-in with the provided username and password.
  Future<void> signIn() async {
    _user = await _authService.signIn(username!, password!);
    userId = username;
    if (!user!.isResetDeviceRequired) {
      authenticated();
    }
  }

  /// Registers a new user using the provided `newUser` details.
  Future<void> signUp() async {
    if (termsAgree) {
      await _authService.signUp(nationalNumber!, rim!, '$phoneCountryCode$phoneNumber');
    } else {
      throw AppException(TranslationsKeys.tkTermsAndConditionsRequiredMsg);
    }
  }

  /// fetch user.
  Future _fetchUserId() async {
    userId = _authService.fetchUserIdFromMemory();
    update();
  }

  /// verify new user using the provided `otp` and 'rim'.
  Future<List<AccountModel>> verifyAccountByOtp() async {
    final response = await _authService.verifyAccountByOtp(rim!, otp!);
    nameEn = response.nameEn;
    nameAr = response.nameAr;
    return response.accounts;
  }

  /// register new user using the validated data.
  Future<String> registerUser(AccountModel primaryAccount) async {
    userId = await _authService.registerAccount(
      nationalNumber!,
      rim!,
      '$phoneCountryCode$phoneNumber',
      nameEn!,
      nameAr!,
      '$whatsappCountryCode$whatsappNumber',
      _termsAgree.value,
      primaryAccount,
    );
    return userId!;
  }

  Future<void> setPassword() async {
    if (password == confirmPassword) {
      await _authService.setPassword(userId!, password!);
    } else {
      throw AppException(TranslationsKeys.tkChangePasswordValidationErrorMsg);
    }
  }

  /// request otp.
  Future<void> requestOtp() async {
    await _authService.requestOtp(_user!.token!);
  }

  /// verify logged in user using `otp`.
  Future<void> resetDevice() async {
    await _authService.resetDevice(otp!, _user!.token!);
  }

  /// Sets the state to authenticated.
  void authenticated() {
    _authState.value = AuthState.authenticated;
    onAuthenticated();
  }

  /// Sets the state to not authenticated.
  void notAuthenticated() {
    _authState.value = AuthState.notAuthenticated;
  }

  /// Sets the state to checking.
  void checking() {
    _authState.value = AuthState.checking;
  }

  /// Checks if the current state is authenticated.
  bool isAuthenticated() {
    return _authState.value == AuthState.authenticated;
  }

  /// Checks if the current state is checking.
  bool isChecking() {
    return _authState.value == AuthState.checking;
  }

  /// Logs out the user and sets the state to not authenticated.
  void logout() {
    _authService.signOut();
    notAuthenticated();
  }

  void onConfirmPasswordChanged(String? newValue) {
    confirmPassword = newValue;
  }

  void onPasswordChange(String? newValue) {
    password = newValue;
  }

  void onTermsAcceptChange(bool? value) {
    _termsAgree.value = value ?? false;
  }
}
