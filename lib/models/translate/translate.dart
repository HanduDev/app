import 'package:app/models/language.dart';

class Translate {
  final String message;

  Translate({required this.message});

  factory Translate.fromJson(Map<String, dynamic> json) {
    return Translate(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
