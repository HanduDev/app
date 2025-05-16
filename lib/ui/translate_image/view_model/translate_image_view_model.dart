import 'package:app/data/repositories/translate/translate_repository.dart';
import 'package:app/models/translate/translate.dart';
import 'package:app/models/translate/translate_image_request.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TranslateImageViewModel extends ChangeNotifier {
  final TranslateRepositoryImageImpl _translateRepository;
  TranslateImageViewModel({
    required TranslateRepositoryImageImpl translateRepository,
  }) : _translateRepository = translateRepository;

  DropdownButtonController fromlanguageController = DropdownButtonController();
  DropdownButtonController tolanguageController = DropdownButtonController();

  Future<String> translateImage(XFile image) async {
    try {
      var translateRequestImage = TranslateImageRequest(
        fromLanguage: fromlanguageController.value.code,
        toLanguage: tolanguageController.value.code,
        image: image,
      );
      Translate response = await _translateRepository.createImage(
        translateRequestImage,
      );

      return response.message;
    } catch (e) {
      if (e.toString().contains('SocketException') ||
          e.toString().contains('Connection refused')) {
        throw Exception(
          'Erro de conexão. Verifique sua internet e tente novamente.',
        );
      }
      throw Exception('Erro ao traduzir a imagem. Tente novamente.');
    }
  }
}
