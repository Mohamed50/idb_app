/// Configuration class for managing API URLs based on the environment.
/// Provides URLs for authentication and other modules.
class APIConfiguration {
  /// TODO: Set the value to `false` before pushing to the repository.
  /// This flag determines whether the app is running in development mode.
  static const bool isDEV = false;

  /// The base URL for the staging environment.
  static const String _stagingUrl = 'https://mob.jsjbank.com:8585/JSB_OMNI_Ph2/omniServices';

  /// The base URL for the production environment.
  static const String _productionUrl = 'http://mb.idb.sd:8585/OMNI_Ph2/omniServices';

  /// The base URL used in the application.
  /// If `isDEV` is true, the staging URL will be used; otherwise, the production URL.
  static const String baseUrl = isDEV ? _stagingUrl : _productionUrl;

  // --- Auth module URLs ---

  /// URL for signing in to the application.
  static const String signInUrl = '$baseUrl/sharedRoutes/login';

  /// URL for signing up a new user.
  static const String signUpUrl = '$baseUrl/sharedRoutes/custSelfRegistration';

  /// URL for registering a new user.
  static const String registerUrl = '$baseUrl/sharedRoutes/regCustSelfRegistration';

  /// URL for verifying register otp.
  static const String verifyAccountByOtpUrl = '$baseUrl/sharedRoutes/validateCustSelfRegistration';

  /// URL for link accounts with user.
  static const String linkAccountsUrl = '$baseUrl/sharedRoutes/linkAccCustSelfRegistration';
  static const String unlinkAccountsUrl = '$baseUrl/sharedRoutes/unlinkCustAcc';

  /// URL for setting user password.
  static const String setAccountPasswordsUrl = '$baseUrl/sharedRoutes/setPwdCustSelfRegistration';

  /// URL for refreshing an existing user session.
  static const String refreshSessionUrl = '$baseUrl/token/refresh';

  /// URL for requesting otp.
  static const String requestOtpUrl = '$baseUrl/sharedRoutes/requestOTP';

  /// URL for verifying otp.
  static const String verifyOtpUrl = '$baseUrl/sharedRoutes/resetDevice';

  /// URL for fetching user security questions.
  static const String securityQuestionsUrl = '$baseUrl/sharedRoutes/getSecurityQuestions';

  /// URL for fetching user security questions.
  static const String submitSecurityQuestionsUrl = '$baseUrl/sharedRoutes/validateSecurityAnswers';

  /// URL for changing user security questions.
  static const String changeSecurityQuestionsUrl = '$baseUrl/sharedRoutes/setSecurityAnswers';

  /// URL for changing password.
  static const String changePasswordUrl = '$baseUrl/sharedRoutes/changePassword';

  /// URL for forgetting password.
  static const String forgetPasswordUrl = '$baseUrl/sharedRoutes/forgetPWD';

  /// URL for fetching user security questions.
  static const String userAccountsUrl = '$baseUrl/sharedRoutes/getAccList';

  /// URL for fetching available accounts.
  static const String getAvailableAccounts = '$baseUrl/bankRoutes/getCustLinkedAccByUser';

  /// URL for fetching user security questions.
  static const String fetchBranchesLocationsUrl = '$baseUrl/sharedRoutes/getBankLandmarks';
  static const String fetchBranchesListUrl = '$baseUrl/sharedRoutes/getBranches';

  /// URL for fetching user security questions.
  static String? forgetPassword = '$baseUrl/sharedRoutes/forgetPWD';

  /// URL for fetching user security questions.
  static const String balanceUrl = '$baseUrl/bankRoutes/getBalance';

  /// Bank Services - [transfer]
  static const String transferBetweenAccountOutsideBankUrl = '$baseUrl/bankRoutes/transferToCard';
  static const String transferBetweenAccountInsideBankUrl = '$baseUrl/bankRoutes/accountTransfer';
  static const String transferBetweenMyOwnAccountUrl = '$baseUrl/bankRoutes/accountTransferOwn';
  static const String fetchAccountInfoInsideBankUrl = '$baseUrl/bankRoutes/getCustInfo';
  static const String fetchAccountInfoOutsideBankUrl = '$baseUrl/bankRoute/otherBankInquiry';

  /// Bank Services - [telecommunication]
  static const String teleTopUpUrl = '$baseUrl/bankRoutes/TopUp';
  static const String teleBillInquiryUrl = '$baseUrl/bankRoutes/BillInquiry';
  static const String teleBillPaymentUrl = '$baseUrl/bankRoutes/BillPayment';
  static const String mockBillPaymentUrl = '$baseUrl/bankRoutes/Billing';

  /// Bank Services - [orders]
  static const String trackOrderStatusUrl = '$baseUrl/sharedRoutes/getBankServStatus';
  static const String requestChequeBookUrl = '$baseUrl/sharedRoutes/reqBankServ';
  static const String trackChequeStatusUrl = '$baseUrl/bankRoutes/getChequeStatus';

  /// Bank Services - [others]
  static const String fetchStatementUrl = '$baseUrl/bankRoutes/getStatement';
  static const String fetchHistoryUrl = '$baseUrl/sharedRoutes/getTranHistory';
  static const String fetchServiceListUrl = '$baseUrl/sharedRoutes/getServList';
  static const String fetchProductsUrl = '$baseUrl/sharedRoutes/getBankProducts';
  static const String fetchExchangeRangeUrl = '$baseUrl/bankRoutes/getCurrencyRates';

  /// settings
  static const String fetchFaqsUrl = '$baseUrl/sharedRoutes/getBankFAQs';
  static const String fetchTransactionsLimitUrl = '$baseUrl/sharedRoutes/getFeesAndLimits';

  static const String getAboutUsUrl = '$baseUrl/sharedRoutes/getAboutBank';
  static const String getTermsAndConditionsUrl = '$baseUrl/sharedRoutes/getBankTerms';
  static const String getContactInfosUrl = '$baseUrl/sharedRoutes/getContactInfo';
}
