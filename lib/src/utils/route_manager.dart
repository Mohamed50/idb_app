import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_page.dart';
import 'package:az_banking_app/src/modules/auth/views/change_password_page.dart';
import 'package:az_banking_app/src/modules/auth/views/change_security_questions_page.dart';
import 'package:az_banking_app/src/modules/auth/views/forgot_password_page.dart';
import 'package:az_banking_app/src/modules/auth/views/link_accounts_page.dart';
import 'package:az_banking_app/src/modules/auth/views/reset_device_page.dart';
import 'package:az_banking_app/src/modules/auth/views/reset_password_page.dart';
import 'package:az_banking_app/src/modules/auth/views/security_questions_page.dart';
import 'package:az_banking_app/src/modules/auth/views/set_password_page.dart';
import 'package:az_banking_app/src/modules/auth/views/verify_account_page.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/bills_bindings.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/views/bill_service_page.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/bills/views/telecommunication_service_page.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/orders_bindings.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/views/request_cheque_book_page.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/views/track_cheque_status_page.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/orders/views/track_order_status_page.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/service_config.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/transfer_bindings.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/views/qr_code_scanner_page.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/views/transfer_between_my_own_accounts_page.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/views/transfer_to_account_inside_bank_page.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/views/transfer_to_account_outside_bank_page.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/views/transfer_with_qr_code_page.dart';
import 'package:az_banking_app/src/modules/bank_services/views/category_page.dart';
import 'package:az_banking_app/src/modules/bank_services/views/response_page.dart';
import 'package:az_banking_app/src/modules/beneficiary/beneficiaries_bindings.dart';
import 'package:az_banking_app/src/modules/beneficiary/views/add_beneficiary_page.dart';
import 'package:az_banking_app/src/modules/beneficiary/views/beneficiaries_page.dart';
import 'package:az_banking_app/src/modules/branches/views/branches_page.dart';
import 'package:az_banking_app/src/modules/exchange_rate/exchange_bindings.dart';
import 'package:az_banking_app/src/modules/exchange_rate/views/exchange_rates_page.dart';
import 'package:az_banking_app/src/modules/faqs/faqs_bindings.dart';
import 'package:az_banking_app/src/modules/faqs/views/faqs_page.dart';
import 'package:az_banking_app/src/modules/home/home.dart';
import 'package:az_banking_app/src/modules/home/view/information_page.dart';
import 'package:az_banking_app/src/modules/home/view/settings_page.dart';
import 'package:az_banking_app/src/modules/products/products_bindings.dart';
import 'package:az_banking_app/src/modules/products/views/products_page.dart';
import 'package:az_banking_app/src/modules/statements/statement_bindings.dart';
import 'package:az_banking_app/src/modules/statements/views/history_page.dart';
import 'package:az_banking_app/src/modules/statements/views/statement_page.dart';
import 'package:az_banking_app/src/modules/transactions_limit/transaction_limit_bindings.dart';
import 'package:az_banking_app/src/modules/transactions_limit/views/transaction_limit_page.dart';
import 'package:get/get.dart';
import '/src/modules/auth/auth_middleware.dart';
import '/src/modules/auth/auth.dart';
import '/src/modules/connections/connection.dart';

/// Manages application routes using GetX for navigation and route handling.
/// Implements a singleton pattern to ensure only one instance exists across the app.
class RouteManager {
  // Singleton instance to ensure only one instance of RouteManager exists.
  static final RouteManager _mInstance = RouteManager._();

  // Getter for accessing the singleton instance.
  static RouteManager get instance => _mInstance;

  // Private list to store the application's routes.
  final List<GetPage> _pages = [];

  // Getter to access the routes list, wrapped with List.unmodifiable for immutability.
  List<GetPage> get pages => List.unmodifiable(_pages);

  // Private constructor to prevent external instantiation.
  RouteManager._();

  // Route constants for better readability and reusability.
  static const String initialRoute = '/';
  static const String authRoute = '/auth';
  static const String registerRoute = '/auth/register';
  static const String forgotPasswordRoute = '/auth/forgot-password';
  static const String securityQuestionsRoute = '/auth/security_questions';
  static const String resetPasswordRoute = '/auth/reset-password';
  static const String resetDeviceRoute = '/auth/reset-device';
  static const String verifyAccountRoute = '/auth/verify-otp';
  static const String linkAccountsRoute = '/auth/register/link-accounts';
  static const String setPasswordRoute = '/auth/register/set-password';

  static const String menuRoute = '/menu';
  static const String informationRoute = '/information';
  static const String branchesRoute = '/branches';
  static const String categoryRoute = '/home/category';
  static const String accountsRoute = '/home/accounts';
  static const String beneficiaryRoute = '/home/beneficiary';
  static const String beneficiaryAddRoute = '/home/beneficiary/Add';
  static const String settingsRoute = '/home/settings';
  static const String changePasswordRoute = '/home/settings/change-password';
  static const String changeSecurityQuestionsRoute = '/home/settings/change-security-questions';
  static const String faqsRoute = '/home/settings/faqs';
  static const String transactionLimitRoute = '/home/settings/transaction-limit';

  /// services - [transfer]
  static const String transferToAccountInsideBankRoute = '/service/transfer/inside-bank';
  static const String transferToAccountOutsideBankRoute = '/service/transfer/outside-bank';
  static const String transferBetweenMyOwnAccountRoute = '/service/transfer/my-own';
  static const String transferWithQrCodeRoute = '/service/transfer/with-qr-code';
  static const String qrCodeScannerRoute = '/qr-code-scanner';

  /// services - [bills]
  static const String teleBillPaymentRoute = '/service/bills/telecommunication';
  static const String electricityPaymentRoute = '/service/bills/electricity';
  static const String e15PaymentRoute = '/service/bills/e15';
  static const String customsPaymentRoute = '/service/bills/customs';
  static const String responseRoute = '/service/response';

  /// services - [orders]
  static const String trackOrderStatusRoute = '/service/orders/track-order-status';
  static const String trackChequeStatusRoute = '/service/orders/track-cheque-status';
  static const String requestChequeBookRoute = '/service/orders/request-cheque-book';

  /// services - [others]
  static const String statementRoute = '/service/other/statement';
  static const String historyRoute = '/service/other/history';
  static const String productsRoute = '/service/other/products';
  static const String exchangeRoute = '/service/others/exchange-rate';

  /// Initializes the routes list by clearing any existing routes and adding new ones.
  ///
  /// Example usage:
  /// ```dart
  /// RouteManager.instance.initialize();
  /// ```
  void initialize() {
    _pages.clear(); // Clears any previously added routes to avoid duplication.
    _pages.addAll(
      [
        GetPage(
          name: initialRoute,
          page: () => const ConnectivityCheckerSplash(),
        ),
        GetPage(
          name: authRoute,
          page: () => const AuthPage(),
          binding: AuthBindings(),
        ),
        GetPage(
          name: registerRoute,
          page: () => const RegisterPage(),
        ),
        GetPage(
          name: verifyAccountRoute,
          page: () => const VerifyAccountPage(),
        ),
        GetPage(
          name: linkAccountsRoute,
          page: () => const LinkAccountsPage(),
        ),
        GetPage(
          name: setPasswordRoute,
          page: () => const SetPasswordPage(),
        ),
        GetPage(
          name: forgotPasswordRoute,
          page: () => const ForgotPasswordPage(),
        ),
        GetPage(
          name: beneficiaryRoute,
          page: () => const BeneficiariesPage(),
          binding: BeneficiariesBindings(),
        ),

        GetPage(
          name: beneficiaryAddRoute,
          page: () => const AddBeneficiaryPage(),
          binding: AddBeneficiariesBindings(),
        ),

        GetPage(
          name: resetDeviceRoute,
          page: () => const ResetDevicePage(),
        ),
        GetPage(name: securityQuestionsRoute, page: () => const SecurityQuestionsPage(), binding: ForgotPasswordBindings()),
        GetPage(
          name: resetPasswordRoute,
          page: () => const ResetPasswordPage(),
        ),
        GetPage(
          name: menuRoute,
          page: () => const HomePage(),
          binding: HomeBindings(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: informationRoute,
          page: () => const InformationPage(),
        ),
        GetPage(
          name: branchesRoute,
          page: () => const BranchesPage(),
          // binding: BranchesBindings()
        ),
        GetPage(
          name: categoryRoute,
          page: () => const CategoryPage(),
        ),
        GetPage(
          name: accountsRoute,
          page: () => const AccountsPage(),
        ),
        GetPage(
          name: qrCodeScannerRoute,
          page: () => const QrCodeScannerPage(),
        ),

        /// settings
        GetPage(
          name: settingsRoute,
          page: () => const SettingsPage(),
        ),
        GetPage(name: changePasswordRoute, page: () => const ChangePasswordPage(), binding: ChangePasswordBindings()),
        GetPage(
            name: changeSecurityQuestionsRoute,
            page: () => const ChangeSecurityQuestionsPage(),
            binding: ChangeSecurityQuestionBindings()),
        GetPage(name: faqsRoute, page: () => const FaqsPage(), binding: FaqsBindings()),
        GetPage(name: transactionLimitRoute, page: () => const TransactionsLimitPage(), binding: TransactionsLimitBindings()),

        /// services - [transfer]
        GetPage(
          name: transferToAccountInsideBankRoute,
          page: () => const TransferToAccountInsideBankPage(),
          binding: TransferBindings(),
        ),
        GetPage(
          name: transferBetweenMyOwnAccountRoute,
          page: () => const TransferBetweenMyOwnAccountsPage(),
          binding: TransferBindings(),
        ),
        GetPage(
          name: transferToAccountOutsideBankRoute,
          page: () => const TransferToAccountOutsideBankPage(),
          binding: TransferBindings(),
        ),
        GetPage(
          name: transferWithQrCodeRoute,
          page: () => const TransferWithQrCodePage(),
          binding: TransferBindings(),
        ),

        /// services - [bills]

        GetPage(
          name: teleBillPaymentRoute,
          page: () => const TelecommunicationServicePage(),
          binding: TeleBillsBindings(),
        ),
        GetPage(
          name: responseRoute,
          page: () => const ResponsePage(),
        ),
        GetPage(
          name: electricityPaymentRoute,
          page: () => const BillServicePage(
              TranslationsKeys.tkBillPaymentElectricityServicesLabel, ServicesConfiguration.topUpElectricityServiceCode),
          binding: BillsBindings(),
        ),
        GetPage(
          name: e15PaymentRoute,
          page: () => const BillServicePage(
            TranslationsKeys.tkBillPaymentE15ServicesLabel,
            ServicesConfiguration.billPaymentEGovServiceCode,
            inquiryBillerId: ServicesConfiguration.billInquiryEGovServiceCode,
          ),
          binding: BillsBindings(),
        ),
        GetPage(
          name: customsPaymentRoute,
          page: () => const BillServicePage(
            TranslationsKeys.tkBillPaymentJamarikServicesLabel,
            ServicesConfiguration.billPaymentCustomsServiceCode,
            inquiryBillerId: ServicesConfiguration.billInquiryCustomsServiceCode,
          ),
          binding: BillsBindings(),
        ),

        /// Services - [orders]

        GetPage(
          name: trackOrderStatusRoute,
          page: () => const TrackOrderStatusPage(),
          binding: OrdersBindings(),
        ),
        GetPage(
          name: trackChequeStatusRoute,
          page: () => const TrackChequeStatusPage(),
          binding: OrdersBindings(),
        ),
        GetPage(
          name: requestChequeBookRoute,
          page: () => const RequestChequeBookPage(),
          binding: OrdersBindings(),
        ),

        /// Services - [others]
        GetPage(
          name: statementRoute,
          page: () => const StatementPage(),
          // binding: StatementBindings(),
        ),
        GetPage(
          name: historyRoute,
          page: () => const HistoryPage(),
          binding: HistoryBindings(),
        ),
        GetPage(
          name: productsRoute,
          page: () => const ProductsPage(),
          binding: ProductsBindings(),
        ),
        GetPage(
          name: exchangeRoute,
          page: () => const ExchangeRatesPage(),
          binding: ExchangeRateBindings(),
        ),
      ],
    );
  }

  /// Navigates to the register page using GetX's named route.
  ///
  /// Example usage:
  /// ```dart
  /// RouteManager.toRegisterPage();
  /// ```
  static void toRegisterPage() {
    Get.toNamed(registerRoute);
  }
}
