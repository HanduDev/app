import 'package:app/models/lesson/lesson_type.dart';

class Lesson {
  final int id;
  final String name;
  final bool hasFinished;
  final String? activityType;

  Lesson({
    required this.id,
    required this.name,
    required this.hasFinished,
    required this.activityType,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      hasFinished: json['hasFinished'] ?? false,
      activityType: json['activityType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hasFinished': hasFinished,
      'activityType': activityType,
    };
  }
}
