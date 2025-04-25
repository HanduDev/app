import 'package:app/models/language.dart';

class Trail {
  final int id;
  final String name;
  final String description;
  final Language language;
  final double progress;

  Trail({
    required this.id,
    required this.name,
    required this.description,
    required this.language,
    required this.progress,
  });

  factory Trail.fromJson(Map<String, dynamic> json) {
    return Trail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      language: Language.fromJson({
        "name": json['language']['name'],
        "acronym": json['language']['code'] ?? json['language']['acronym'],
      }),
      progress: json['progress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'language': language.toJson(),
      'progress': progress,
    };
  }
}
