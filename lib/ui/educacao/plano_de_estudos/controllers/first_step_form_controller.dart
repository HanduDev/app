import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_multiple_controller.dart';
import 'package:flutter/material.dart';

class FirstStepFormController extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController theme = TextEditingController();
  DropdownButtonController languageController = DropdownButtonController();
  DropdownMultipleController developmentsController =
      DropdownMultipleController();
  DropdownMultipleController themesController = DropdownMultipleController();

  void setThemes(List<String> themes) {
    notifyListeners();
  }

  bool validate() {
    return _formKey.currentState!.validate();
  }
}
