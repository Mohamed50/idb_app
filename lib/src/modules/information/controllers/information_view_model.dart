import 'package:az_banking_app/src/modules/information/data/information_service.dart';
import 'package:get/get.dart';

class InformationViewModel extends GetxController{
  final InformationService _service;

  String? aboutUsContent, contactUsContent, termsAndConditionsContent;

  InformationViewModel(this._service);


  @override
  void onInit() {
    _fetchData();
    super.onInit();
  }

  void _fetchData() {
    _fetchAboutUs();
    _fetchContactUs();
    _fetchTermsAndConditions();
  }

  void _fetchAboutUs() async {
    aboutUsContent = await _service.fetchAboutUs();
  }
  void _fetchContactUs() async {
    contactUsContent = await _service.fetchContactInfo();
  }
  void _fetchTermsAndConditions() async {
    termsAndConditionsContent = await _service.fetchTermsAndConditions();
  }


}