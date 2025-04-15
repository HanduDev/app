import 'package:app/models/translate/translate.dart';
import 'package:app/models/translate/translate_text_request.dart';

abstract class TranslateRepositoryImpl {
  Future<Translate> create(TranslateTextRequest translateRequest);
}


