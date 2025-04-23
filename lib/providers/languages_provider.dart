import 'package:app/data/repositories/language/language_repository.dart';
import 'package:app/models/language.dart';
import 'package:flutter/material.dart';

class LanguagesProvider extends ChangeNotifier {
  final LanguageRepositoryImpl _languageRepository;
  LanguagesProvider({required LanguageRepositoryImpl languageRepository})
    : _languageRepository = languageRepository{getAllLanguages();}

  List<Language> _languages = [];

  List<Language> get languages => List.unmodifiable(_languages);

  Future<void> getAllLanguages() async {
    try {
      _languages = await _languageRepository.getAllLanguages();
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }
}
