import 'dart:convert';

import 'package:az_banking_app/src/config/colors.dart';
import 'package:az_banking_app/src/modules/accounts/data/models/account_model.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_list.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeDialog extends StatelessWidget {
  final AccountModel accountModel;

  const QrCodeDialog({super.key, required this.accountModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
