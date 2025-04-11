import 'package:flutter/material.dart';

class FirstStepFormController extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  List<String> _developments = [];
  List<String> _themes = [];
  Map<String, String>? language;

  List<String> get developments => _developments;
  List<String> get themes => _themes;
  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController theme = TextEditingController();

  void setDevelopments(List<String> developments) {
    _developments = developments;
    notifyListeners();
  }

  void setThemes(List<String> themes) {
    _themes = themes;
    notifyListeners();
  }
}
