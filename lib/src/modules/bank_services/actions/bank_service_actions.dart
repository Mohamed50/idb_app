import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/category_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/service_model.dart';
import 'package:az_banking_app/src/modules/bank_services/modules/transfer/views/qr_code_scanner_page.dart';
import 'package:az_banking_app/src/utils/route_manager.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '/src/essentials/config/action_presenter.dart';

class BankServicesActions extends ActionPresenter {
  static final BankServicesActions _mInstance = BankServicesActions._();

  static BankServicesActions get instance => _mInstance;

  BankServicesActions._();

  void toServicePage(ServiceModel serviceModel) {
    if (serviceModel.route == RouteManager.transferWithQrCodeRoute) {
      _handleTransferWithQrCode();
    } else {
      Get.toNamed(serviceModel.route);
    }
  }

  void toResponsePage(Map<String, dynamic> response) {
    Get.toNamed(RouteManager.responseRoute, arguments: response);
  }

  Future _handleTransferWithQrCode() async {
    actionHandlerWithoutLoading(() async {
      String? scannedQr = await Get.to(() => QrCodeScannerPage());
      AccountModel toAccount = accountModelFromJson(json.decode(scannedQr!)['Accounts_List']).first;
      Get.toNamed(RouteManager.transferWithQrCodeRoute, arguments: toAccount);
    });
  }

  Future screenshot(Uint8List? image) async {
    actionHandlerWithoutLoading(() async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = File('${directory.path}/screenshot.png');
        await imagePath.writeAsBytes(image);
        showSuccessSnackBar('', TranslationsKeys.tkDownloadedMsg);
      } else {
        throw Exception();
      }
    });
  }

  Future<void> share(Uint8List? image) async {
    actionHandlerWithoutLoading(() async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = File('${directory!.path}/screenshot.png');
        await imagePath.writeAsBytes(image);
        await Share.shareXFiles([XFile(imagePath.path)]);
      } else {
        throw Exception();
      }
    });
  }

  void done() {
    Get.until((route) => route.settings.name == RouteManager.authRoute);
  }

  void toCategoryPage(CategoryModel categoryModel) {
    Get.toNamed(RouteManager.categoryRoute, arguments: categoryModel);
  }
}
