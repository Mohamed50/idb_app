import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/essentials/services/api_service.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/category_model.dart';
import 'package:az_banking_app/src/modules/bank_services/data/model/service_model.dart';
import 'package:az_banking_app/src/utils/utils.dart';

class BankServicesService extends ApiService {
  Future<List<CategoryModel>> fetchCategories() async {
    await Future.delayed(Duration(milliseconds: 300));
    return [
      CategoryModel(
        name: TranslationsKeys.tkBeneficiariesLabel,
        iconPath: AssetsManager.icBeneficiaryPath,
        route: RouteManager.beneficiaryRoute,
        services: [
          ServiceModel(TranslationsKeys.tkBeneficiariesLabel, AssetsManager.icBeneficiaryPath, RouteManager.beneficiaryRoute),
        ],
      ),
      CategoryModel(
        name: TranslationsKeys.tkTransferServicesLabel,
        iconPath: AssetsManager.icTransferPath,
        route: 'route',
        services: [
          ServiceModel(
            TranslationsKeys.tkTransferOutsideBankServicesSmallLabel,
            AssetsManager.icTransferBetweenAccountPath,
            RouteManager.transferToAccountOutsideBankRoute,
          ),
          ServiceModel(
            TranslationsKeys.tkTransferInsideBankLabel,
            AssetsManager.icTransferInsideBankPath,
            RouteManager.transferToAccountInsideBankRoute,
          ),
          ServiceModel(
            TranslationsKeys.tkTransferBetweenMyAccountsLabel,
            AssetsManager.icTransferBetweenAccountPath,
            RouteManager.transferBetweenMyOwnAccountRoute,
          ),
          ServiceModel(
            TranslationsKeys.tkTransferWithQRLabel,
            AssetsManager.icTransferWithQRPath,
            RouteManager.transferWithQrCodeRoute,
          ),
        ],
      ),
      CategoryModel(
        name: TranslationsKeys.tkBillPaymentServicesLabel,
        iconPath: AssetsManager.icBillPath,
        route: 'route',
        services: [
          ServiceModel(
            TranslationsKeys.tkBillPaymentTelecommunicationServicesLabel,
            AssetsManager.icBillTelecommunicationPath,
            RouteManager.teleBillPaymentRoute,
          ),
          ServiceModel(
            TranslationsKeys.tkBillPaymentElectricityServicesLabel,
            AssetsManager.icBillElectricityPath,
            RouteManager.electricityPaymentRoute,
          ),
          ServiceModel(
            TranslationsKeys.tkBillPaymentJamarikServicesLabel,
            AssetsManager.icBillCustomsPath,
            RouteManager.customsPaymentRoute,
          ),
          ServiceModel(
            TranslationsKeys.tkBillPaymentE15ServicesLabel,
            AssetsManager.icBillE15Path,
            RouteManager.e15PaymentRoute,
          ),
          // ServiceModel(TranslationsKeys.tkBillPaymentPortsServicesLabel, AssetsManager.icBillPortsPath, 'route'),
        ],
      ),
      CategoryModel(
        name: TranslationsKeys.tkOrdersServiceLabel,
        iconPath: AssetsManager.icOrderPath,
        route: 'route',
        services: [
          ServiceModel(
            TranslationsKeys.tkTrackOrdersStatusServiceLabel,
            AssetsManager.icOrderPath,
            RouteManager.trackOrderStatusRoute,
          ),
          ServiceModel(
            TranslationsKeys.tkRequestChequeBookServiceLabel,
            AssetsManager.icOrderChequePath,
            RouteManager.requestChequeBookRoute,
          ),
          ServiceModel(
            TranslationsKeys.tkTrackChequeStatusServiceLabel,
            AssetsManager.icOrderChequeStatusPath,
            RouteManager.trackChequeStatusRoute,
          ),
        ],
      ),
      CategoryModel(
        name: TranslationsKeys.tkStatementServiceLabel,
        iconPath: AssetsManager.icStatementPath,
        route: 'route',
        services: [
          ServiceModel(
            TranslationsKeys.tkStatementServiceLabel,
            AssetsManager.icStatementPath,
            RouteManager.statementRoute,
          ),
        ],
      ),
      CategoryModel(
        name: TranslationsKeys.tkHistoryServiceLabel,
        iconPath: AssetsManager.icStatementPath,
        route: 'route',
        services: [
          ServiceModel(
            TranslationsKeys.tkHistoryServiceLabel,
            AssetsManager.icStatementPath,
            RouteManager.historyRoute,
          ),
        ],
      ),
      CategoryModel(
        name: TranslationsKeys.tkOtherServiceLabel,
        iconPath: AssetsManager.icOrderPath,
        route: 'route',
        services: [
          ServiceModel(TranslationsKeys.tkProductsServiceLabel, AssetsManager.icProductsPath, RouteManager.productsRoute),
          ServiceModel(
              TranslationsKeys.tkViewExchangeRateServiceLabel, AssetsManager.icExchangeRatePath, RouteManager.exchangeRoute),
        ],
      ),
    ];
  }

  Future<List<ServiceModel>> fetchServices() async {
    await Future.delayed(Duration(milliseconds: 300));
    final categories = await fetchCategories();
    List<ServiceModel> services = [];
    categories.removeWhere((e) => e.name == TranslationsKeys.tkTransferServicesLabel);
    await Future.forEach(categories, (e) => services.addAll(e.services));
    return services;
  }
}
