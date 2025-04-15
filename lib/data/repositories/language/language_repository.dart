import 'package:app/models/language.dart';

abstract class LanguageRepositoryImpl {
  Future<List<Language>> getAllLanguages();
}
