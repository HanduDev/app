import 'package:app/models/lesson/lesson.dart';
import 'package:app/models/lesson/lesson_info.dart';

abstract class LessonRepositoryImpl {
  Future<List<Lesson>> getAllLessons();
  Future<LessonInfo> getLessonById(int id);
}