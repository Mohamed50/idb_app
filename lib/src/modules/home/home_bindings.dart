import 'package:az_banking_app/src/modules/accounts/account_binding.dart';
import 'package:az_banking_app/src/modules/bank_services/bank_bindings.dart';
import 'package:az_banking_app/src/modules/statements/statement_bindings.dart';
import 'package:get/get.dart';

/// A class responsible for binding dependencies for the `MenuViewModel`.
///
/// This class ensures that the `MenuViewModel` is lazily initialized and registered
/// only once using the GetX dependency injection system.
/// It implements the [Bindings] interface from GetX.
class HomeBindings implements Bindings {
  /// Registers the [MenuViewModel] if it's not already registered.
  ///
  /// This method is called by GetX to inject the required dependencies when needed.
  @override
  void dependencies() {
    AccountBindings().dependencies();
    BankServiceBindings().dependencies();
    StatementBindings().dependencies();
  }
}
