import 'package:app/data/repositories/translate/translate_repository.dart';
import 'package:app/data/services/http.dart';
import 'package:app/models/translate/translate.dart';
import 'package:app/models/translate/translate_text_request.dart';


class TranslateRepositoryRemote extends TranslateRepositoryImpl {
  final HttpServiceImpl _httpService;

  TranslateRepositoryRemote({required HttpServiceImpl httpService})
    : _httpService = httpService;

  @override
  Future<Translate> create(TranslateTextRequest translateRequest) async {
    var response = await _httpService.post('/translate_text', {
      'translate': translateRequest.toJson(),
    });

    return Translate.fromJson(response);
  }
}