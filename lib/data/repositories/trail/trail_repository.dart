import 'package:app/models/trail/trail.dart';
import 'package:app/models/trail/trail_info.dart';
import 'package:app/models/trail/trail_request.dart';

abstract class TrailRepositoryImpl {
  Future<Trail> create(TrailRequest trailRequest);
  Future<List<Trail>> getAll();
  Future<TrailInfo> getById(int id);
}
