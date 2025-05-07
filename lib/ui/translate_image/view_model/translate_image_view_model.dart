import 'package:app/data/repositories/translate/translate_repository.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:flutter/material.dart';

class TranslateImageViewModel extends ChangeNotifier {
  final TranslateRepositoryImpl _translateRepository;
  TranslateImageViewModel({required TranslateRepositoryImpl translateRepository})
    : _translateRepository = translateRepository;

  DropdownButtonController fromlanguageController = DropdownButtonController();
  DropdownButtonController tolanguageController = DropdownButtonController();
}