import 'service_model.dart';

class CategoryModel {
  final String iconPath;
  final String name;
  final String route;
  final List<ServiceModel> services;

  CategoryModel({required this.name, required this.iconPath, required this.route, required this.services});
}
