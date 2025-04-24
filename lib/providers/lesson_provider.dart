import 'package:app/data/repositories/lesson/lesson_repository.dart';
import 'package:app/models/lesson/lesson.dart';
import 'package:flutter/material.dart';

class LessonProvider extends ChangeNotifier {
  final LessonRepositoryImpl _lessonRepository;
  LessonProvider({required LessonRepositoryImpl lessonRepository})
    : _lessonRepository = lessonRepository {
    getAllLessons().catchError((_) {});
  }

  List<Lesson> _lessons = [];

  List<Lesson> get lessons => List.unmodifiable(_lessons);

  Future<void> getAllLessons() async {
    try {
      _lessons = await _lessonRepository.getAllLessons();
      notifyListeners();
    } catch (_) {
    } finally {
      notifyListeners();
    }
  }
}
