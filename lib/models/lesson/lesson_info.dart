import 'package:app/models/lesson/lesson.dart';
import 'package:app/models/option.dart';

class LessonInfo extends Lesson {
  final String? content;
  final List<Option>? options;
  final String? question;
  final String? userAnswer;

  LessonInfo({
    required super.id,
    required super.name,
    required super.hasFinished,
    required this.content,
    required super.activityType,
    this.options,
    this.question,
    this.userAnswer,
  });

  factory LessonInfo.fromJson(Map<String, dynamic> json) {
    return LessonInfo(
      id: json['id'],
      name: json['name'],
      hasFinished: json['hasFinished'] ?? false,
      content: json['content'] ?? '',
      activityType: json['activityType'] ?? '',
      question: json['question'] ?? '',
      userAnswer: json['userAnswer'] ?? '',
      options:
          json['options'] != null
              ? (json['options'] as List)
                  .map((option) => Option.fromJson(option))
                  .toList()
              : null,
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
