import 'package:app/data/repositories/translate/translate_repository.dart';
import 'package:app/models/language.dart';
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

  Future<String> translateText(String text) async {
    try {
      var translateRequest = TranslateTextRequest(
        text: text,
        fromLanguage: fromlanguageController.value.code,
        toLanguage: tolanguageController.value.code,
      );
      Translate response = await _translateRepository.create(translateRequest);

      return response.message;
    } catch (e) {
      return 'Error: $e';
    }
  }

  void swapLanguages() {
    var temp = fromlanguageController.value;
    fromlanguageController.value = tolanguageController.value;
    tolanguageController.value = temp;
    notifyListeners();
  }

  void setDefaultLanguage(Language? language) {
    fromlanguageController.value = language;
    notifyListeners();
  }
}
