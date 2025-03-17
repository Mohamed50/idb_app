import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '/src/utils/utils.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:get/get.dart';
import '/src/config/config.dart';
import '/src/utils/binding.dart';
import 'modules/locale/data/services/localization_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayWidgetBuilder: (context)=> const SpinKitDoubleBounce(
        color: ColorManager.primaryColor,
        size: 50.0,
      ),
      child: GetMaterialApp(
        initialBinding: InitialBindings(),
        getPages: RouteManager.instance.pages,
        translations: LocalizationService(),
        locale: LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        theme: theme,
      ),
    );
  }

}
