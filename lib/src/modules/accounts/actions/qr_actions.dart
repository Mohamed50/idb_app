import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

/// **Capture a widget image and share it**
///
// ────────────────────────────────────────────────
Future<void> shareWidgetImage(GlobalKey key, {String fileName = 'qr.png', double scale = 3.0, String? text}) async {
  // Ensure the widget is laid out
  final context = key.currentContext;
  if (context == null) {
    await Future.delayed(const Duration(milliseconds: 16));
  }
  final boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;

  // Higher pixelRatio = sharper image
  final dpr = MediaQuery.of(key.currentContext!).devicePixelRatio;
  final image = await boundary.toImage(pixelRatio: dpr * scale);

  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final bytes = byteData!.buffer.asUint8List();

  final dir = await getTemporaryDirectory();
  final path = '${dir.path}/$fileName';
  await File(path).writeAsBytes(bytes);

  await Share.shareXFiles([XFile(path)], text: text ?? 'Scan me');
}

/// Generate a QR (PNG) for [data] and share it.
Future<void> shareQrPng(String data, {double size = 1024, String fileName = 'qr.png'}) async {
  // Build the QR into PNG bytes (transparent bg)
  final painter = QrPainter(
    data: data,
    version: QrVersions.auto,
    eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: ui.Color(0xFF000000)),
    dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: ui.Color(0xFF000000)),
  );

  final ByteData? pngBytes = await painter.toImageData(size, format: ui.ImageByteFormat.png);
  if (pngBytes == null) return;

  // Optionally add a white background (recommended for dark UIs)
  final withBg = await _composeOnWhiteBg(pngBytes);

  // Save to a temp file and share
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/$fileName');
  await file.writeAsBytes(withBg);
  await Share.shareXFiles([XFile(file.path)], text: 'Scan me');
}

Future<Uint8List> _composeOnWhiteBg(ByteData pngBytes) async {
  final codec = await ui.instantiateImageCodec(pngBytes.buffer.asUint8List());
  final frame = await codec.getNextFrame();
  final img = frame.image;

  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  final paint = ui.Paint()..color = const ui.Color(0xFFFFFFFF);
  canvas.drawRect(ui.Rect.fromLTWH(0, 0, img.width.toDouble(), img.height.toDouble()), paint);
  canvas.drawImage(img, ui.Offset.zero, ui.Paint());
  final out = await recorder.endRecording().toImage(img.width, img.height);
  final bytes = await out.toByteData(format: ui.ImageByteFormat.png);
  return bytes!.buffer.asUint8List();
}

/// **Pick an image and read QR content**
///
/// - Opens gallery
/// - Runs on-device ML to detect QR/barcodes
/// - Returns the first QR value (or null)
///
// ────────────────────────────────────────────────

Future<String?> pickAndReadQrSmart() async {
  final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (picked == null) return null;

  final input = InputImage.fromFilePath(picked.path);
  final scanner = BarcodeScanner(formats: [BarcodeFormat.qrCode]);

  try {
    final barcodes = await scanner.processImage(input);
    Barcode? qr = barcodes.firstWhereOrNull(
      (b) => b.format == BarcodeFormat.qrCode && (b.rawValue?.isNotEmpty ?? false),
    );
    if (qr == null) return null;
    return qr.rawValue; // <-- your decoded value
  } finally {
    await scanner.close();
  }
}
