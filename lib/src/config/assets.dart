/// A manager class to store asset paths used across the app.
///
/// Prevents hardcoding asset paths multiple times and centralizes
/// the management of all images, icons, and other assets.
class AssetsManager {
  // Private constructor to prevent instantiation.
  AssetsManager._();

  // **Images**
  /// Path for the Opaala logo in white.
  static const String logoPath = 'assets/images/logo.png';

  /// Path for the application icon.
  static const String appIconPath = 'assets/icons/logo.png';
  static const String icMoneyPath = 'assets/icons/money.png';

  // **Icons**
  /// Path for the money transfer icons.
  static const String _transferIconDirectoryPath = 'assets/icons/transfer';
  static const String icTransferPath = '$_transferIconDirectoryPath/transfer.png';
  static const String icTransferBetweenBanksPath = '$_transferIconDirectoryPath/transfer_between_banks.png';
  static const String icTransferBetweenAccountPath = '$_transferIconDirectoryPath/transfer_between_accounts.png';
  static const String icTransferInsideBankPath = '$_transferIconDirectoryPath/transfer_inside_bank.png';
  static const String icTransferWithQRPath = '$_transferIconDirectoryPath/transfer_with_qr.png';
  static const String icQRPath = '$_transferIconDirectoryPath/qr.png';

  /// Path for the money bill icons.
  static const String _billIconDirectoryPath = 'assets/icons/bills';
  static const String icBillPath = '$_billIconDirectoryPath/bill.png';
  static const String icBillElectricityPath = '$_billIconDirectoryPath/bill_electricity.png';
  static const String icBillCustomsPath = '$_billIconDirectoryPath/bill_customs.png';
  static const String icBillE15Path = '$_billIconDirectoryPath/bill_e15.png';
  static const String icBillPortsPath = '$_billIconDirectoryPath/bill_ports.png';
  static const String icBillZainPath = '$_billIconDirectoryPath/bill_zain.png';
  static const String icBillSudaniPath = '$_billIconDirectoryPath/bill_sudani.png';
  static const String icBillMtnPath = '$_billIconDirectoryPath/bill_mtn.png';
  static const String icBillTelecommunicationPath = '$_billIconDirectoryPath/bill_telecommunication.png';


  /// Path for the orders icons.
  static const String _ordersIconDirectoryPath = 'assets/icons/orders';
  static const String icOrderPath = '$_ordersIconDirectoryPath/orders.png';
  static const String icOrderChequePath = '$_ordersIconDirectoryPath/orders_cheque.png';
  static const String icOrderChequeStatusPath = '$_ordersIconDirectoryPath/orders_cheque_status.png';


  /// Path for the orders icons.
  static const String _othersIconDirectoryPath = 'assets/icons/others';
  static const String icStatementPath = '$_othersIconDirectoryPath/statement.png';
  static const String icProductsPath = '$_othersIconDirectoryPath/products.png';
  static const String icExchangeRatePath = '$_othersIconDirectoryPath/exchange.png';


  static const String _cardsDesignsDirectoryPath = 'assets/icons/cards/';
  static const String icCardDesignOnePath = '$_cardsDesignsDirectoryPath/card_design_1.svg';
  static const String icCardDesignTwoPath = '$_cardsDesignsDirectoryPath/card_design_2.svg';

  static const String _settingIconsDirectoryPath = 'assets/icons/settings';
  static const String icAccountsPath = '$_settingIconsDirectoryPath/accounts.png';
  static const String icChangePasswordPath = '$_settingIconsDirectoryPath/change_password.png';
  static const String icFaqPath = '$_settingIconsDirectoryPath/faq.png';
  static const String icLanguagePath = '$_settingIconsDirectoryPath/language.png';
  static const String icSecurityQuestionsPath = '$_settingIconsDirectoryPath/security_questions.png';
  static const String icTransactionLimitPath = '$_settingIconsDirectoryPath/transaction_limit.png';
  static const String icLogoutPath = '$_settingIconsDirectoryPath/logout.png';
  static const String icUserPath = '$_settingIconsDirectoryPath/user.png';
}
