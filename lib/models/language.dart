class Language {
  final String name;
  final String code;

  Language({required this.name, required this.code});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(name: json['email'], code: json['fullName']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'code': code};
  }
}
