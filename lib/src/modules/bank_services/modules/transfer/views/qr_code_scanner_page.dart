import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/actions/qr_actions.dart';
import 'package:az_banking_app/src/utils/route_manager.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:az_banking_app/src/views/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

/// **QR Code Scanner Page**
///
/// This page allows users to scan a QR code and returns the scanned result.
///
/// **Features:**
/// - Camera preview for scanning QR codes.
/// - Returns the scanned data.
/// - Clean UI with easy-to-use interface.
///
// ─────────────────────────────────────────────────────
class QrCodeScannerPage extends StatefulWidget {
  const QrCodeScannerPage({super.key});

  @override
  State<QrCodeScannerPage> createState() => _QrCodeScannerPageState();
}

class _QrCodeScannerPageState extends State<QrCodeScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrResult;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: TranslationsKeys.tkScanQrCodeLabel),
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: ColorManager.primaryColor,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: MediaQuery.of(context).size.width * 0.7,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                height: 100.0,
                padding: EdgeInsets.all(24.0),
                child: CustomButton(
                  text: TranslationsKeys.tkUploadQrCodeBtn,
                  onPressed: uploadQrCode,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void uploadQrCode() async {
    qrResult = await pickAndReadQrSmart();
    Get.back(result: qrResult);
  }

  /// **Handles the QR code scanning process.**
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.distinct().listen((scanData) {
      if (qrResult != scanData.code) {
        qrResult = scanData.code;
        Get.back(result: qrResult);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
