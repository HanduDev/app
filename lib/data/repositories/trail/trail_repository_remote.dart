import 'package:app/data/repositories/trail/trail_repository.dart';
import 'package:app/data/services/http.dart';
import 'package:app/models/trail/trail.dart';
import 'package:app/models/trail/trail_info.dart';
import 'package:app/models/trail/trail_request.dart';

class TrailRepositoryRemote extends TrailRepositoryImpl {
  final HttpServiceImpl _httpService;

  TrailRepositoryRemote({required HttpServiceImpl httpService})
    : _httpService = httpService;

  @override
  Future<Trail> create(TrailRequest trailRequest) async {
    var response = await _httpService.post('/trails', {
      'trail': trailRequest.toJson(),
    });
    return Trail.fromJson(response['trail']);
  }

  @override
  Future<List<Trail>> getAll() async {
    var response = await _httpService.get('/trails');
    return response['trails'].map<Trail>((e) => Trail.fromJson(e)).toList();
  }

  @override
  Future<TrailInfo> getById(int id) async {
    var response = await _httpService.get('/trails/$id');
    return TrailInfo.fromJson(response['trail']);
  }
}
