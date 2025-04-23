import 'package:app/models/lesson/lesson.dart';

abstract class LessonRepositoryImpl {
  Future<List<Lesson>> getAllLessons();
}