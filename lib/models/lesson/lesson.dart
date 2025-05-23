import 'package:localization/localization.dart';

class Lesson {
  final int id;
  final String name;
  final bool hasFinished;
  final String? activityType;
  final bool isCorrect;

  Lesson({
    required this.id,
    required this.name,
    required this.hasFinished,
    required this.activityType,
    required this.isCorrect,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      hasFinished: json['hasFinished'] ?? false,
      activityType: json['activityType'],
      isCorrect:
          json['isCorrect'] is bool
              ? json['isCorrect']
              : json['isCorrect'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hasFinished': hasFinished,
      'activityType': activityType,
      'isCorrect': isCorrect,
    };
  }

  bool get isTheorical {
    return activityType == 'theorical';
  }

  String get title {
    return isTheorical
        ? name.split(":").first.trim()
        : "lesson.activity_practice".i18n();
  }

  String get subtitle {
    return isTheorical
        ? name.split(":").last.trim()
        : "lesson.activity_type.$activityType".i18n();
  }
}
