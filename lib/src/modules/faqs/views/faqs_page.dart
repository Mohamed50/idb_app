import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/faqs/controllers/faqs_view_model.dart';
import 'package:az_banking_app/src/modules/products/controllers/products_view_model.dart';
import 'package:az_banking_app/src/views/custom/api_handler.dart';
import 'package:az_banking_app/src/views/custom/custom_appbar.dart';
import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class FaqsPage extends GetView<FaqsViewModel> {
  const FaqsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightBackgroundColor,
      appBar: CustomAppbar(title: TranslationsKeys.tkFaqsLabel,),
      body: ListView(
        padding: EdgeInsets.all(24.0),
        children: [
          Obx(
            () => ApiHandler(
              apiResponse: controller.faqs,
              onSuccess: HtmlWidget(controller.faqs.data ?? ''),
            ),
          ),
        ],
      ),
    );
  }
}
