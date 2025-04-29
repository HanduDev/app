class Lesson {
  final int id;
  final String name;
  final bool hasFinished;

  Lesson({required this.id, required this.name, required this.hasFinished});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      hasFinished: json['hasFinished'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'hasFinished': hasFinished};
  }
}
