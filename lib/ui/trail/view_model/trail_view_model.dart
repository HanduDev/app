import 'package:app/data/repositories/trail/trail_repository.dart';
import 'package:app/models/trail/trail_info.dart';
import 'package:flutter/material.dart';

class TrailViewModel extends ChangeNotifier {
  final TrailRepositoryImpl _trailRepository;

  TrailViewModel({required TrailRepositoryImpl trailRepository})
    : _trailRepository = trailRepository;

  TrailInfo? _trail;
  TrailInfo? get trail => _trail;

  Future<TrailInfo> initialize(int id) async {
    return await _trailRepository.getById(id);
  }
}
