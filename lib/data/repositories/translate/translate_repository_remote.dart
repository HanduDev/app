import 'package:app/data/repositories/translate/translate_repository.dart';
import 'package:app/data/services/http.dart';
import 'package:app/models/translate/translate.dart';
import 'package:app/models/translate/translate_image_request.dart';
import 'package:app/models/translate/translate_text_request.dart';
import 'dart:io';
import 'package:app/models/translate/translate_video_request.dart';

class TranslateRepositoryRemote
    implements
        TranslateRepositoryImpl,
        TranslateRepositoryImageImpl,
        TranslateRepositoryVideoImpl {
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

  @override
  Future<Translate> createImage(TranslateImageRequest translateRequest) async {
    final imageFile = File(translateRequest.image.path);
    final imageBytes = await imageFile.readAsBytes();

    var response = await _httpService.postMultipart(
      '/translate_text',
      {
        'translate[from_language]': translateRequest.fromLanguage,
        'translate[to_language]': translateRequest.toLanguage,
      },
      {'translate[image]': imageBytes},
    );

    return Translate.fromJson(response);
  }

  @override
  Future<Translate> createVideo(TranslateVideoRequest translateRequest) async {
    var response = await _httpService.postMultipart('/translate_video', {}, {
      'translate[video]': translateRequest.getImageBytes(),
    });

    return Translate.fromJson(response);
  }
}
