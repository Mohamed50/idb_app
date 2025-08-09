import 'package:az_banking_app/src/essentials/services/memory_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import '/src/utils/route_manager.dart';
import 'src/app.dart';

Future<void> main() async {
  RouteManager.instance.initialize();
  await MemoryService.instance.initialize();
  runApp(Phoenix(child: const App()));
}


