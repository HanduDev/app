import 'package:app/data/repositories/trail/trail_repository.dart';
import 'package:app/models/trail/trail_info.dart';
import 'package:flutter/material.dart';

class TrailViewModel extends ChangeNotifier {
  final TrailRepositoryImpl _trailRepository;

  TrailViewModel({required TrailRepositoryImpl trailRepository})
    : _trailRepository = trailRepository;

  TrailInfo? _trail;
  TrailInfo? get trail => _trail;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> initialize(int id) async {
    try {
      _isLoading = true;
      notifyListeners();

      _trail = await _trailRepository.getById(id);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
