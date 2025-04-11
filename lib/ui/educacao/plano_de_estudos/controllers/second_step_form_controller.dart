import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:flutter/material.dart';

class SecondStepFormController {
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  DropdownButtonController level = DropdownButtonController();
  DropdownButtonController timeToLearn = DropdownButtonController();
  DropdownButtonController timeToStudy = DropdownButtonController();

  void submit() {}
}
