import 'package:app/data/repositories/lesson/check_answer/check_answer_repository.dart';
import 'package:app/data/services/http.dart';

class CheckAnswerRepositoryRemote extends CheckAnswerRepositoryImpl {
  final HttpServiceImpl _httpService;

  CheckAnswerRepositoryRemote({required HttpServiceImpl httpService})
    : _httpService = httpService;

  @override
  Future<bool> checkAnswer(int trailId, String answer) async {
    var response = await _httpService.put('/trails/check_answer/$trailId', {
      'answer': answer,
    });

    return response['correct'];
  }
}
