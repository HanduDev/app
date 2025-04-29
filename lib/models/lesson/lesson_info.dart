import 'package:app/models/lesson/lesson.dart';

class LessonInfo extends Lesson {
  final String content;

  LessonInfo({
    required super.id,
    required super.name,
    required super.hasFinished,
    required this.content,
  });

  factory LessonInfo.fromJson(Map<String, dynamic> json) {
    return LessonInfo(
      id: json['id'],
      name: json['name'],
      hasFinished: json['hasFinished'] ?? false,
      content: json['content'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hasFinished': hasFinished,
      'content': content,
    };
  }
}
