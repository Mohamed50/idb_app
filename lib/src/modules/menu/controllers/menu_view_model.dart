import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A [MenuViewModel] class to manage the state and behavior of the menu pages.
/// This class uses [GetX] for reactive state management.
class MenuViewModel extends GetxController {
  /// Observable index to track the currently selected page.
  final RxInt _selectedIndex = 0.obs;

  /// Getter to access the current selected index.
  int get selectedIndex => _selectedIndex.value;

  PageController pageController = PageController();

  /// Constructor to initialize the default selected page.
  MenuViewModel();

  /// Method to change the selected page based on the provided [index].
  /// If the index is valid, the corresponding page is set as the selected page.
  /// If the index is out of bounds, the expanded state is toggled.
  void onPageChanges(int index) {
    _selectedIndex.value = index;
    update(); // Notify listeners about the change.
  }

  void onIndexChanges(int index) {
    _selectedIndex.value = index;
    pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
    update(); // Notify listeners about the change.
  }
}
