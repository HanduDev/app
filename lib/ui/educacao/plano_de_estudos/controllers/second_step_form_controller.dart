import 'package:flutter/material.dart';

class SecondStepFormController {
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController level = TextEditingController();
  TextEditingController timeToLearn = TextEditingController();
  TextEditingController timeToStudy = TextEditingController();
}
