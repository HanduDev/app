import 'package:app/data/repositories/lesson/lesson_repository.dart';
import 'package:app/data/services/http.dart';
import 'package:app/models/lesson/lesson.dart';

class LessonRepositoryRemote extends LessonRepositoryImpl {
  final HttpServiceImpl _httpService;

  LessonRepositoryRemote({required HttpServiceImpl httpService})
    : _httpService = httpService;

  @override
  Future<List<Lesson>> getAllLessons() async {
    var response = await _httpService.get('/lessons');

    return response["lessons"].map<Lesson>((lesson) => Lesson.fromJson(lesson)).toList();
  }

}