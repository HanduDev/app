import 'package:app/data/repositories/lesson/lesson_repository.dart';
import 'package:app/models/lesson/lesson_info.dart';
import 'package:flutter/material.dart';

class LessonViewModel extends ChangeNotifier {
  final LessonRepositoryImpl _lessonRepository;

  LessonInfo? _lesson;

  LessonInfo? get lesson => _lesson;

  LessonViewModel({required LessonRepositoryImpl lessonRepository})
    : _lessonRepository = lessonRepository;

  Future<LessonInfo> initialize(int id) async {
    return await _lessonRepository.getLessonById(id);
  }
}
