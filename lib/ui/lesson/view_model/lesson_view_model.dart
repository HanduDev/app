import 'package:app/data/repositories/lesson/lesson_repository.dart';
import 'package:app/data/repositories/lesson/check_answer/check_answer_repository.dart';
import 'package:app/models/lesson/lesson_info.dart';
import 'package:app/models/lesson/lesson_update_request.dart';
import 'package:flutter/material.dart';

class LessonViewModel extends ChangeNotifier {
  final LessonRepositoryImpl _lessonRepository;
  final CheckAnswerRepositoryImpl _checkAnswerRepository;

  bool isAnswering = false;

  LessonInfo? _lesson;

  LessonInfo? get lesson => _lesson;

  LessonViewModel({
    required LessonRepositoryImpl lessonRepository,
    required CheckAnswerRepositoryImpl checkAnswerRepository,
  }) : _lessonRepository = lessonRepository,
       _checkAnswerRepository = checkAnswerRepository;

  Future<LessonInfo> initialize(int id) async {
    return await _lessonRepository.getLessonById(id);
  }

  Future<bool> checkAnswer(int trailId, String answer) async {
    try {
      isAnswering = true;
      notifyListeners();
      return await _checkAnswerRepository.checkAnswer(trailId, answer);
    } catch (e) {
      rethrow;
    } finally {
      isAnswering = false;
      notifyListeners();
    }
  }

  Future<void> update(LessonUpdateRequest lessonUpdateRequest) async {
    return await _lessonRepository.update(lessonUpdateRequest);
  }
}
