import 'package:app/data/repositories/language/language_repository.dart';
import 'package:app/data/services/secure_storage.dart';
import 'package:app/models/language.dart';
import 'package:flutter/material.dart';

class LanguagesProvider extends ChangeNotifier {
  final LanguageRepositoryImpl _languageRepository;
  final SecureStorage _secureStorage;

  LanguagesProvider({
    required LanguageRepositoryImpl languageRepository,
    required SecureStorage secureStorage,
  }) : _languageRepository = languageRepository,
       _secureStorage = secureStorage;

  List<Language> _languages = [];
  List<Language> get languages => List.unmodifiable(_languages);

  Language? _defaultLanguage;
  Language? get defaultLanguage => _defaultLanguage;

  Future<void> getAllLanguages() async {
    final locale = await _secureStorage.read('locale') ?? 'pt-BR';

    if (_languages.isEmpty) {
      _languages = await _languageRepository.getAllLanguages();
    }

    try {
      _defaultLanguage = getLanguageByCode(locale);
      notifyListeners();
    } catch (_) {
      _defaultLanguage = null;
      notifyListeners();
    }
  }

  Language? getLanguageByCode(String code) {
    List<String> codes = code.split('-');

    if (compareLanguageCodes(codes[0], codes[1])) {
      return _languages.firstWhere(
        (language) => compareLanguageCodes(language.code, codes[0]),
      );
    }

    return _languages.firstWhere(
      (language) => compareLanguageCodes(language.code, code),
    );
  }

  bool compareLanguageCodes(String code1, String code2) {
    return code1.toLowerCase() == code2.toLowerCase();
  }
}
