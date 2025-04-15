import 'package:app/data/repositories/language/language_repository.dart';
import 'package:app/data/services/http.dart';
import 'package:app/models/language.dart';


class LanguageRepositoryRemote extends LanguageRepositoryImpl {
  final HttpServiceImpl _httpService;

  LanguageRepositoryRemote({required HttpServiceImpl httpService})
    : _httpService = httpService;

  @override
  Future<List<Language>> getAllLanguages() async {
    var response = await _httpService.get('/languages');

    return response["languages"].map<Language>((language) => Language.fromJson(language)).toList();
  }
}