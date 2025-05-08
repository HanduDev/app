import 'package:app/data/repositories/lesson/lesson_repository.dart';
import 'package:app/data/services/http.dart';
import 'package:app/models/lesson/lesson.dart';
import 'package:app/models/lesson/lesson_info.dart';
import 'package:app/models/lesson/lesson_update_request.dart';

class LessonRepositoryRemote extends LessonRepositoryImpl {
  final HttpServiceImpl _httpService;

  LessonRepositoryRemote({required HttpServiceImpl httpService})
    : _httpService = httpService;

  @override
  Future<List<Lesson>> getAllLessons() async {
    var response = await _httpService.get('/lessons');

    return response["lessons"]
        .map<Lesson>((lesson) => Lesson.fromJson(lesson))
        .toList();
  }

  @override
  Future<LessonInfo> getLessonById(int id) async {
    var response = await _httpService.get('/lessons/$id');

    return LessonInfo.fromJson(response["lesson"]);
  }

  @override
  Future<void> update(LessonUpdateRequest lessonUpdateRequest) async {
    await _httpService.put('/lessons/${lessonUpdateRequest.id}', {
      'lesson': lessonUpdateRequest.toJson(),
    });
  }
}
