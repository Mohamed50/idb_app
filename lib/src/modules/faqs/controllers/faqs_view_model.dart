import 'package:az_banking_app/src/essentials/config/api_response.dart';
import 'package:az_banking_app/src/modules/faqs/data/services/faqs_service.dart';
import 'package:get/get.dart';

class FaqsViewModel extends GetxController {
  final FaqsService _faqsService;

  final Rx<ApiResponse<String>> _faqs = ApiResponse<String>.idle().obs;

  ApiResponse<String> get faqs => _faqs.value;

  FaqsViewModel(this._faqsService) {
    _initialize();
  }

  void _initialize() {
    _fetchFaqs();
  }

  void _fetchFaqs() {
    apiFetch(_faqsService.fetchFaqs()).listen((value) => _faqs.value = value);
  }
}
