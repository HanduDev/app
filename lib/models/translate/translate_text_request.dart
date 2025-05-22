class TranslateTextRequest {
  String text;
  String fromLanguage;
  String toLanguage;

  TranslateTextRequest({
    required this.text,
    required this.fromLanguage,
    required this.toLanguage,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'from_language': fromLanguage,
      'to_language': toLanguage,
    };
  }
}
