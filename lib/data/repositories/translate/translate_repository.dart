import 'package:app/models/translate/translate.dart';
import 'package:app/models/translate/translate_image_request.dart';
import 'package:app/models/translate/translate_text_request.dart';

abstract class TranslateRepositoryImpl {
  Future<Translate> create(TranslateTextRequest translateRequest);
}

abstract class TranslateRepositoryImageImpl {
  Future<Translate> createImage(TranslateImageRequest translateRequest);
}