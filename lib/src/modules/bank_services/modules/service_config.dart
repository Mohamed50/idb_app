import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/utils/get_utils.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/cupertino.dart';

class ServicesConfiguration {
  static const transferBetweenAccountsServiceCode = '2001';
  static const transferBetweenMyOwnAccountsServiceCode = '2002';

  static const topUpZainServiceCode = '2101';
  static const topUpMtnServiceCode = '2102';
  static const topUpSudaniServiceCode = '2103';

  static const billInquiryZainServiceCode = '2201';
  static const billPaymentZainServiceCode = '2301';

  static const billInquiryMtnServiceCode = '2202';
  static const billPaymentMtnServiceCode = '2302';

  static const billInquirySudaniServiceCode = '2203';
  static const billPaymentSudaniServiceCode = '2303';

  static const topUpElectricityServiceCode = '2104';
  static const topUpMoheServiceCode = '2105';
  static const topUpMoheArabicServiceCode = '2106';

  static const billInquiryEGovServiceCode = '2204';
  static const billPaymentEGovServiceCode = '2304';

  static const billInquiryCustomsServiceCode = '2205';
  static const billPaymentCustomsServiceCode = '2305';

  /// **Returns a human-readable description based on the service code**
  static String getServiceMainFiledLabel(String serviceCode) {
    switch (serviceCode) {
      case topUpZainServiceCode:
      case topUpMtnServiceCode:
      case topUpSudaniServiceCode:
      case billInquiryZainServiceCode:
      case billPaymentZainServiceCode:
      case billInquiryMtnServiceCode:
      case billPaymentMtnServiceCode:
      case billInquirySudaniServiceCode:
      case billPaymentSudaniServiceCode:
        return TranslationsKeys.tkPhoneLabel;
      case topUpElectricityServiceCode:
        return TranslationsKeys.tkMeterNumberLabel;
      case topUpMoheServiceCode:
        return "MOHE Top-Up (English)";
      case topUpMoheArabicServiceCode:
        return "MOHE Top-Up (Arabic)";

      case billInquiryEGovServiceCode:
      case billPaymentEGovServiceCode:
      return TranslationsKeys.tkE15ReceiptNumberLabel;

      case billInquiryCustomsServiceCode:
      case billPaymentCustomsServiceCode:
      return TranslationsKeys.tkBankCodeLabel;

      default:
        return "Unknown Service Code";
    }
  }

  static List<Widget> getServiceResponseItems(Map<String, dynamic> response) {
    final List<Widget> children = [];
    final billerId = response['Biller_ID'];
    response.forEach(
      (k, v) {
        if (v is List) {
          for (var e in v) {
            children.add(InfoRow(label: e['Info_Lable'], value: e['Info_Value'].toString()));
          }
        } else {
          if (k == 'Pay_Customer_Code') {
            k = ServicesConfiguration.getServiceMainFiledLabel(billerId);
          }
          if (k == 'Tran_DateTime') {
            v = Utils.getAzFormattedDateTime(v);
          }
          if (v != null && v.toString().isNotEmpty) {
            children.add(
              InfoRow(label: k, value: v.toString()),
            );
          }
        }
      },
    );
    return children;
  }

  static Map<String, dynamic> getServiceResponse(Map<String, dynamic> response) {
    final Map<String, dynamic> info = {};
    final billerId = response['Biller_ID'];
    response.forEach(
      (k, v) {
        if (v is List) {
          for (var e in v) {
            info.addAll({e['Info_Lable']:e['Info_Value'].toString()});
          }
        } else {
          if (k == 'Pay_Customer_Code') {
            k = ServicesConfiguration.getServiceMainFiledLabel(billerId);
          }
          if (k == 'Tran_DateTime') {
            v = Utils.getAzFormattedDateTime(v);
          }
          if (v != null && v.toString().isNotEmpty) {
            info.addAll({k:v.toString()});
          }
        }
      },
    );
    return info;
  }

  static String? getServiceSecondaryFiledLabel(String billerId) {
    switch (billerId) {
      case topUpZainServiceCode:
      case topUpMtnServiceCode:
      case topUpSudaniServiceCode:
      case billInquiryZainServiceCode:
      case billPaymentZainServiceCode:
      case billInquiryMtnServiceCode:
      case billPaymentMtnServiceCode:
      case billInquirySudaniServiceCode:
      case billPaymentSudaniServiceCode:
      case topUpElectricityServiceCode:
        return null;
      case topUpMoheServiceCode:
      case topUpMoheArabicServiceCode:
        return TranslationsKeys.tkSelectCourseLabel;

      case billInquiryEGovServiceCode:
      case billPaymentEGovServiceCode:
        return TranslationsKeys.tkPhoneLabel;

      case billInquiryCustomsServiceCode:
      case billPaymentCustomsServiceCode:
        return TranslationsKeys.tkDeclarantCodeLabel;

      default:
        return "Unknown Service Code";
    }
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomText.subtitle(
            label,
            fontSize: 12.0,
          ),
        ),
        CustomText.title(
          value.toString(),
          fontSize: 14.0,
          maxLines: 2,
        ),
      ],
    );
  }
}
