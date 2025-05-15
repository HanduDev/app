import 'package:camera/camera.dart';

class TranslateImageRequest {
  XFile image;
  String fromLanguage;
  String toLanguage;

  TranslateImageRequest({
    required this.fromLanguage,
    required this.toLanguage,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'from_language': fromLanguage,
      'to_language': toLanguage,
      'image': image.path,
    };
  }
}
