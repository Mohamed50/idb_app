import 'dart:convert';
import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/actions/qr_actions.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_list.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeDialog extends StatelessWidget {
  final AccountModel accountModel;
  final GlobalKey qrKey = GlobalKey();
  QrCodeDialog({super.key, required this.accountModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RepaintBoundary(
            key: qrKey,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Column(
                children: [
                  AccountQrCode(accountModel: accountModel),
                  SizedBox(height: 12.0),
                  AccountItemTile(
                    accountModel: accountModel,
                    backgroundColor: ColorManager.primaryColor.withValues(alpha: 0.08),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomButton(
              text: TranslationsKeys.tkShareLabel,
              onPressed: () => shareWidgetImage(qrKey),
            ),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }
}

class AccountQrCode extends StatelessWidget {
  final AccountModel accountModel;
  final Color color;

  const AccountQrCode({super.key, required this.accountModel, this.color = ColorManager.primaryColor});

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: json.encode(accountModel.toJson()),
      version: QrVersions.auto,
      dataModuleStyle: QrDataModuleStyle(color: color, dataModuleShape: QrDataModuleShape.circle),
      eyeStyle: QrEyeStyle(
        color: color,
        eyeShape: QrEyeShape.circle,
      ),
    );
  }
}
