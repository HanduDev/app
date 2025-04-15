import 'package:app/data/repositories/translate/translate_repository.dart';
import 'package:app/models/translate/translate.dart';
import 'package:app/models/translate/translate_text_request.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:flutter/material.dart';

class TranslateTextViewModel extends ChangeNotifier {
  final TranslateRepositoryImpl _translateRepository;
  TranslateTextViewModel({required TranslateRepositoryImpl translateRepository})
    : _translateRepository = translateRepository;

  DropdownButtonController fromlanguageController = DropdownButtonController();
  DropdownButtonController tolanguageController = DropdownButtonController();
  String translatedText = '';  

  Future<void> translateText(String text) async {
    try {
      var translateRequest = TranslateTextRequest(
        text: text,
        fromLanguage: fromlanguageController.value["countryCode"],
        toLanguage: tolanguageController.value["countryCode"],
      );
      Translate response = await _translateRepository.create(translateRequest);
      translatedText = response.message;
    } catch (e) {
      print('Error: $e');
    }
  }
}
