import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class IntroductionViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  final List<String> _titles = [
    'intro.titles.0'.i18n(),
    'intro.titles.1'.i18n(),
    'intro.titles.2'.i18n(),
  ];

  int get currentIndex => _currentIndex;
  String get title => _titles[_currentIndex];

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
