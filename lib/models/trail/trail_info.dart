import 'package:app/models/language.dart';
import 'package:app/models/lesson/lesson.dart';
import 'package:app/models/trail/trail.dart';

class TrailInfo extends Trail {
  final List<Lesson> lessons;

  TrailInfo({
    required super.id,
    required super.name,
    required super.description,
    required super.language,
    required super.progress,
    required this.lessons,
  });

  factory TrailInfo.fromJson(Map<String, dynamic> json) {
    return TrailInfo(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      language: Language.fromJson({
        "name": json['language']['name'],
        "acronym": json['language']['code'] ?? json['language']['acronym'],
      }),
      progress: json['progress'],
      lessons:
          json['lessons']
              .map<Lesson>((lesson) => Lesson.fromJson(lesson))
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'language': language.toJson(),
      'progress': progress,
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
    };
  }
}
