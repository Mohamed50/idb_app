import 'package:az_banking_app/src/essentials/services/memory_service.dart';
import 'package:flutter/material.dart';
import '/src/utils/route_manager.dart';
import 'src/app.dart';

Future<void> main() async {
  RouteManager.instance.initialize();
  await MemoryService.instance.initialize();
  runApp(const App());
}


