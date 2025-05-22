class LessonRequest {
  int id;
  String name;
  bool hasFinished;

  LessonRequest({
    required this.id,
    required this.name,
    required this.hasFinished,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'has_finished': hasFinished};
  }
}
