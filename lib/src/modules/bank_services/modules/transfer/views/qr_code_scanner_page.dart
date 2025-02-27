import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/utils/route_manager.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
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
      appBar: CustomAppbar(title: TranslationsKeys.tkTransferWithQRLabel),
      body: Column(
        children: [
          // QR Code Scanner View
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
          ),

          // Display the scanned result
          Expanded(
            child: Center(
              child: qrResult != null
                  ? Text('QR Code Result: $qrResult', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                  : const Text('Scan a QR code', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
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
