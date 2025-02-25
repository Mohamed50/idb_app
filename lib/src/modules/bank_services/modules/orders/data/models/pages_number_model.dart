import 'package:az_banking_app/src/config/config.dart';
import 'package:get/get.dart';

class PagesNumberModel {
  final int numberOfPages;
  final int code;

  PagesNumberModel(this.numberOfPages, this.code);

  factory PagesNumberModel.smallBook() => PagesNumberModel(25, 1002);

  factory PagesNumberModel.largeBook() => PagesNumberModel(50, 1001);

  @override
  String toString() {
    return '$numberOfPages ${TranslationsKeys.tkPagesLabel.tr}';
  }
}
