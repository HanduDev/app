import 'package:app/models/lesson/lesson.dart';
import 'package:app/models/option.dart';

class LessonInfo extends Lesson {
  final String? content;
  final List<Option>? options;
  final String? question;
  final String? userAnswer;
  final int attemptCount;
  final String? expectedAnswer;

  LessonInfo({
    required super.id,
    required super.name,
    required super.hasFinished,
    required super.activityType,
    required super.isCorrect,
    required this.content,
    required this.attemptCount,
    this.options,
    this.question,
    this.userAnswer,
    this.expectedAnswer,
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
      isCorrect:
          json['isCorrect'] is bool
              ? json['isCorrect']
              : json['isCorrect'] == 1,
      attemptCount: json['attemptCount'] ?? 0,
      expectedAnswer: json['expectedAnswer'],
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

  LessonInfo copyWith({int? attemptCount}) {
    return LessonInfo(
      id: id,
      name: name,
      hasFinished: hasFinished,
      activityType: activityType,
      isCorrect: isCorrect,
      content: content,
      attemptCount: attemptCount ?? this.attemptCount,
      options: options,
      question: question,
      userAnswer: userAnswer,
      expectedAnswer: expectedAnswer,
    );
  }
}
