import '../keys.dart';

const Map<String, String> englishTranslationsMap = {
  TranslationsKeys.appName: 'IDB',
  TranslationsKeys.tkApiError: 'API Error',
  TranslationsKeys.tkNetworkError: 'Network Error',
  TranslationsKeys.tkFetchingError: 'Fetching Error',
  TranslationsKeys.tkError: 'Error',
  TranslationsKeys.tkSomethingWentWrongMsg: 'Something went wrong',
  TranslationsKeys.tkNoInternetMsg: 'No internet connection',
  TranslationsKeys.tkNoInternetTryAgainMsg: 'No internet connection, please try again',
  TranslationsKeys.tkCheckNetworkFailedMsg: 'Failed to get Network Status',
  TranslationsKeys.tkHomePage: 'Home',
  TranslationsKeys.tkLoginPage: 'Login',
  TranslationsKeys.tkRegisterPage: 'Register',
  TranslationsKeys.tkChooseLanguage: 'Choose Language',

  /// Auth Module - Login Page
  TranslationsKeys.tkLoginWelcomeMsg: 'Welcome to Industrial Development Bank',
  TranslationsKeys.tkUsernameLabel: 'Username',
  TranslationsKeys.tkUsernameRequiredMsg: 'Username is required',
  TranslationsKeys.tkPasswordLabel: 'Password',
  TranslationsKeys.tkCurrentPasswordLabel: 'Current Password',
  TranslationsKeys.tkNewPasswordLabel: 'New Password',
  TranslationsKeys.tkConfirmNewPasswordLabel: 'Confirm Password',
  TranslationsKeys.tkPasswordRequiredMsg: 'Password is required',
  TranslationsKeys.tkForgetPasswordLabel: 'Forget Password?',
  TranslationsKeys.tkSignInBtn: 'Sign In',
  TranslationsKeys.tkNoAccountLabel: 'Don\'t have an account?',
  TranslationsKeys.tkNoDataLabel: 'No data',
  TranslationsKeys.tkRegisterNowLabel: 'Register Now',
  TranslationsKeys.tkAboutUsLabel: 'About Us',
  TranslationsKeys.tkAboutUsContent:
      'Industrial Development Bank is one of the pioneering financial institutions in Sudan that introduced and practiced Islamic banking. Established in September 1981, the bank has played a significant role in shaping the country\'s financial landscape by providing Sharia-compliant banking solutions. Over the years, it has expanded its services to cater to various sectors, including trade, investment, and development financing, ensuring financial inclusion and economic growth. With a strong commitment to innovation and customer-centric services, the bank continues to support businesses and individuals while adhering to the principles of Islamic finance.',
  TranslationsKeys.tkTermsContent: """
Terms and Conditions

Last Updated: [DD/MM/YYYY]

Welcome to [Your App Name]!

Please read these Terms and Conditions ("Terms", "Terms and Conditions") carefully before using the [Your App Name] application or website (the "Service") operated by [Your Company Name] ("us", "we", or "our").

By accessing or using the Service, you agree to be bound by these Terms. If you do not agree, please do not use the Service.

1. Use of the Service
- You must be at least 18 years old or have the permission of a legal guardian to use this Service.
- You agree not to misuse or attempt to disrupt the functionality of the Service.

2. User Accounts
- When you create an account, you must provide accurate and complete information.
- You are responsible for maintaining the confidentiality of your login credentials.

3. Intellectual Property
- All content, trademarks, logos, and other intellectual property are owned by or licensed to [Your Company Name].
- You may not reproduce, distribute, or exploit any content from the Service without permission.

4. Third-Party Services
- The Service may contain links to third-party websites or services. We are not responsible for the content, policies, or practices of these third parties.

5. Limitation of Liability
- We do not guarantee uninterrupted or error-free access to the Service.
- In no event shall we be liable for any indirect, incidental, or consequential damages arising out of the use of the Service.

6. Termination
- We reserve the right to suspend or terminate access to the Service at any time, without prior notice, for any reason.

7. Changes to Terms
- We may update these Terms from time to time. Continued use of the Service after changes implies acceptance of the new Terms.

8. Contact Us
If you have any questions about these Terms, please contact us at:
[Your Support Email]
""",
  TranslationsKeys.tkBranchesLabel: 'Branches',
  TranslationsKeys.tkContactUsLabel: 'Contacts',
  TranslationsKeys.tkWebsiteLabel: 'Website',

  /// Auth Module - Register Page
  TranslationsKeys.tkRegisterWelcomeMsg: 'Register an Account',
  TranslationsKeys.tkRegisterSuccessMsg: 'Account created successfully please verify your phone number',
  TranslationsKeys.tkNationalNumberLabel: 'National Number',
  TranslationsKeys.tkNationalNumberRequiredMsg: 'National Number is required',
  TranslationsKeys.tkRimLabel: 'RIM',
  TranslationsKeys.tkRimRequiredMsg: 'RIM is required',
  TranslationsKeys.tkPhoneLabel: 'Phone Number',
  TranslationsKeys.tkPhoneRequiredMsg: 'Phone number is required',
  TranslationsKeys.tkPhoneNotValidMsg: 'Phone number must be a valid phone number',
  TranslationsKeys.tkSignUpBtn: 'Sign Up',
  TranslationsKeys.tkHaveAccountLabel: 'Already have an account?',
  TranslationsKeys.tkIAgreeLabel: 'I agree to',
  TranslationsKeys.tkTermsAndConditions: 'terms and conditions',
  TranslationsKeys.tkTermsAndConditionsRequiredMsg: 'you have to accept terms and conditions to sign up',
  TranslationsKeys.tkLoginNowLabel: 'Login Now',
  TranslationsKeys.tkLinkAccountsLabel: 'Link Accounts',
  TranslationsKeys.tkLinkAccountsDescription: 'Select the accounts you want to link to this user',
  TranslationsKeys.tkLinkAccountsSuccessMsg: 'Accounts linked successfully',
  TranslationsKeys.tkPasswordSetWelcomeMsg: 'please set your password',
  TranslationsKeys.tkPasswordSetSuccessMsg: 'Password set successfully',


  /// Auth Module - Password Reset Page
  TranslationsKeys.tkPasswordResetWelcomeMsg: 'Reset your old password',
  TranslationsKeys.tkPasswordResetBtn: 'Reset Password',
  TranslationsKeys.tkOrLabel: 'Or',
  TranslationsKeys.tkContactCustomerServiceBtn: 'Contact Customer Service',
  TranslationsKeys.tkBackToLogin: 'Back to login',
  TranslationsKeys.tkResetDeviceWelcomeMsg: 'Please enter the code you received in you phone to use your account on this device',
  TranslationsKeys.tkResetDeviceBtn: 'Reset Device',
  TranslationsKeys.tkOtpLabel: 'One time password',
  TranslationsKeys.tkOtpRequiredMsg: 'Code is required',
  TranslationsKeys.tkResetDeviceSuccessMsg: 'Device reset done successfully',
  TranslationsKeys.tkSecurityQuestionsWelcomeMsg: 'Please Answer these questions to reset your password',
  TranslationsKeys.tkAnswerLabel: 'Answer',
  TranslationsKeys.tkAnswerRequiredLabel: 'Answer is required',
  TranslationsKeys.tkResetPasswordWelcomeMsg: 'Enter the new password to access your account',
  TranslationsKeys.tkResetPasswordSuccessMsg: 'Your password reset done successfully',
  TranslationsKeys.tkChangePasswordLabel: 'Change Password',
  TranslationsKeys.tkChangePasswordWelcomeMsg: 'Enter the old password and new password to change it',
  TranslationsKeys.tkChangePasswordValidationErrorMsg: 'new password and confirm new password are not the same',
  TranslationsKeys.tkChangePasswordSuccessMsg: 'Your password change done successfully',
  TranslationsKeys.tkSecurityQuestionsLabel: 'Security Questions',
  TranslationsKeys.tkChangeSecurityQuestionsLabel: 'Change security questions',
  TranslationsKeys.tkChangeSecurityQuestionsWelcomeMsg: 'Change you answers and submit to save the new answers',
  TranslationsKeys.tkChangeSecurityQuestionsValidationErrorMsg: 'Some answers are missing',
  TranslationsKeys.tkChangeSecurityQuestionsSuccessMsg: 'Security questions update done successfully',



  TranslationsKeys.tkConfirmBtn: 'Confirm',
  TranslationsKeys.tkVerifyAccountWelcomeMsg: 'Please enter the code you received in you phone to verify your account',
  TranslationsKeys.tkVerifyAccountSuccessMsg: 'Account verified successfully',
  TranslationsKeys.tkVerifyBtn: 'Verify',
  TranslationsKeys.tkWelcomeLabel: 'Welcome',
  TranslationsKeys.tkBalanceLabel: 'Balance',
  TranslationsKeys.tkAccountNoLabel: 'Account No',
  TranslationsKeys.tkIbanLabel: 'IBAN',
  TranslationsKeys.tkAccountCopiedSuccessMsg: 'Account details copied',
  TranslationsKeys.tkInfoLabel: 'Info',
  TranslationsKeys.tkMyAccountsLabel: 'My Accounts',

// 🏦 Bank Services Module - Transfer Services
  TranslationsKeys.tkServicesLabel: 'Services',
  TranslationsKeys.tkBeneficiariesLabel: 'Beneficiaries',
  TranslationsKeys.tkAddBeneficiaryLabel: 'Add To Beneficiaries',
  TranslationsKeys.tkTypeLabel: 'Type',
  TranslationsKeys.tkTeleProviderLabel: 'Telecom Provider',
  TranslationsKeys.tkTeleServiceTypeLabel: 'Number Type',
  TranslationsKeys.tkAddBeneficiarySuccessMsg: 'Beneficiary added successfully',
  TranslationsKeys.tkNoBeneficiariesLabel: 'You don\'t have beneficiaries yet',
  TranslationsKeys.tkBeneficiaryExistMsg: 'You can\'t add the same beneficiary more than one',
  TranslationsKeys.tkTransferServicesLabel: 'Transfer',
  TranslationsKeys.tkTransferOutsideBankServicesLabel: 'Outside',
  TranslationsKeys.tkTransferInsideBankLabel: 'Inside',
  TranslationsKeys.tkTransferBetweenMyAccountsLabel: 'Between',
  TranslationsKeys.tkTransferWithQRLabel: 'QR Code',
  TranslationsKeys.tkScanQrCodeLabel: 'Scan QR code',
  TranslationsKeys.tkGeneralRequiredMsg: 'This field is required',
  TranslationsKeys.tkFromAccountLabel: 'From Account',
  TranslationsKeys.tkToAccountLabel: 'To Account',
  TranslationsKeys.tkToAccountBBANLabel: 'To Account (BBAN)',
  TranslationsKeys.tkToAccountTypeLabel: 'To Account Type',
  TranslationsKeys.tkAmountLabel: 'Amount',
  TranslationsKeys.tkCommentsLabel: 'Comments',
  TranslationsKeys.tkOneAccountErrorMsg: 'You have one account only',
  TranslationsKeys.tkLinkedAccounts: 'Linked Accounts',
  TranslationsKeys.tkAccountTypeLabel: 'Account Type',
  TranslationsKeys.tkTransactionInfoLabel: 'Transaction Information',
  TranslationsKeys.tkReceiverNameLabel: 'Receiver Name',
  TranslationsKeys.tkSDGLabel: 'SDG',

  // 📑 Bank Services Module - Statement Services
  TranslationsKeys.tkStatementServiceLabel: 'Statement',
  TranslationsKeys.tkCancelLabel: 'Cancel',
  TranslationsKeys.tkCloseLabel: 'Close',
  TranslationsKeys.tkSelectDateLabel: 'Select date',
  TranslationsKeys.tkDateLabel: 'Date',
  TranslationsKeys.tkFromLabel: 'From',
  TranslationsKeys.tkToLabel: 'To',
  TranslationsKeys.tkTransactionsLabel: 'Transactions',
  TranslationsKeys.tkLast5Label: 'Last 5',
  TranslationsKeys.tkWeekLabel: 'Week',
  TranslationsKeys.tkMonthLabel: 'Month',
  TranslationsKeys.tkCustomLabel: 'Custom',
  TranslationsKeys.tkViewMoreLabel: 'View more',

  // 💳 Bank Services Module - Pay Bills Services
  TranslationsKeys.tkBillPaymentServicesLabel: 'Bill Payment',
  TranslationsKeys.tkBillPaymentTelecommunicationServicesLabel: 'Telecommunication',
  TranslationsKeys.tkBillPaymentZainServicesLabel: 'Pay Zain Bill',
  TranslationsKeys.tkTopUpLabel: 'Top Up',
  TranslationsKeys.tkBillInquiryLabel: 'Bill Inquiry',
  TranslationsKeys.tkBillPaymentLabel: 'Bill Payment',
  TranslationsKeys.tkBillPaymentSudaniServicesLabel: 'Pay Sudani Bill',
  TranslationsKeys.tkBillPaymentMtnServicesLabel: 'Pay MTN Bill',
  TranslationsKeys.tkBillPaymentElectricityServicesLabel: 'Electricity',
  TranslationsKeys.tkBillPaymentJamarikServicesLabel: 'Jamarik',
  TranslationsKeys.tkBillPaymentE15ServicesLabel: 'Government',
  TranslationsKeys.tkBillPaymentPortsServicesLabel: 'Ports',
  TranslationsKeys.tkMeterNumberLabel: 'Meter Number',
  TranslationsKeys.tkE15ReceiptNumberLabel: 'E15 Receipt Number',
  TranslationsKeys.tkDeclarantCodeLabel: 'Declarant Code',
  TranslationsKeys.tkBankCodeLabel: 'Bank Code',

  // 📦 Bank Services Module - Orders Services
  TranslationsKeys.tkOrdersServiceLabel: 'Orders',
  TranslationsKeys.tkTrackOrdersStatusServiceLabel: 'Track Order Status',
  TranslationsKeys.tkRequestChequeBookServiceLabel: 'Request Cheque Book',
  TranslationsKeys.tkTrackChequeStatusServiceLabel: 'Cheque Status',
  TranslationsKeys.tkChequeNumberLabel: 'Cheque Number',
  TranslationsKeys.tkChequeTypeLabel: 'Cheque Type',
  TranslationsKeys.tkPagesLabel: 'Pages',
  TranslationsKeys.tk25PagesChequeBookLabel: 'Cheque book 25',
  TranslationsKeys.tk50PagesChequeBookLabel: 'Cheque book 50',
  TranslationsKeys.tkReceivingBranchLabel: 'Receiving branch',
  TranslationsKeys.tkNameLabel: 'Name',
  'pending': 'Pending',
  'rejected': 'Rejected',
  'approved': 'Approved',
  'cancelled': 'Cancelled',

  // 🛠️ Bank Services Module - Other Services
  TranslationsKeys.tkOtherServiceLabel: 'Other',
  TranslationsKeys.tkProductsServiceLabel: 'Products',
  TranslationsKeys.tkViewExchangeRateServiceLabel: 'Exchange Rates',
  TranslationsKeys.tkCurrencyLabel: 'Currency',
  TranslationsKeys.tkBuyLabel: 'Buy',
  TranslationsKeys.tkSellLabel: 'Sell',
  TranslationsKeys.tkAverageLabel: 'Average',
  TranslationsKeys.tkSuccessLabel: 'Success',
  TranslationsKeys.tkSuccessfulTransactionMsg: 'Your transaction was successful',
  TranslationsKeys.tkShareLabel: 'Share',
  TranslationsKeys.tkScreenshotLabel: 'Screenshot',
  TranslationsKeys.tkDoneLabel: 'Done',
  TranslationsKeys.tkAnotherTransactionLabel: 'Another Transaction',
  TranslationsKeys.tkDownloadedMsg: 'Screenshot downloaded successfully',

  /// settings
  TranslationsKeys.tkSettingsLabel: 'Settings',
  TranslationsKeys.tkFaqsLabel: 'FAQs',
  TranslationsKeys.tkTransactionLimitLabel: 'Limits & Fees',
  TranslationsKeys.tkAccountInfoNotAvailableMsg: 'Account info not available',
  TranslationsKeys.tkTransactionCanceledMsg: 'Transaction was cancelled by the user',
  TranslationsKeys.tkDuplicatedTransactionMsg: 'This transaction was already submitted recently. Do you want to proceed again?',
  TranslationsKeys.tkYesLabel: 'Yes',
  TranslationsKeys.tkNoLabel: 'No',
  TranslationsKeys.tkLogoutLabel: 'Logout',

  'BeneficiaryType.inside': 'Inside Bank',
  'BeneficiaryType.outside': 'Outside Bank',
  'BeneficiaryType.electricity': 'Electricity',
  'BeneficiaryType.telecommunication': 'Telecom',

  'TeleProvider.mtn': 'MTN',
  'TeleProvider.sudani': 'Sudani',
  'TeleProvider.zain': 'Zain',

  'TeleServiceType.topUp': 'Top Up',
  'TeleServiceType.payment': 'Payment',

  /// response
  "Response_Code": "Response Code",
  "Comment": "Remarks",
  "Reference_No": "Reference Number",
  "Response_Message": "Response Status",
  "Tran_DateTime": "Transaction Date & Time",
  "Amount": "Transaction Amount",
  "test": "Test",
  "Successful": "Transaction Successful",
  "Biller_ID": "Biller Id",
  "Currency_Code": "Currency Code",
  "Customer_Name": "Receiver Name",
};
