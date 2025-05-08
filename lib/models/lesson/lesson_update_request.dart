class LessonUpdateRequest {
  final int id;
  final bool hasFinished;

  LessonUpdateRequest({required this.id, required this.hasFinished});

  Map<String, dynamic> toJson() {
    return {'id': id, 'has_finished': hasFinished};
  }
}
