import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int currentIndex = 0;
  bool hasInitialized = false;

  void setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void resetInitialization() {
    hasInitialized = false;
    notifyListeners();
  }
}
