import 'package:app/data/repositories/trail/trail_repository.dart';
import 'package:app/models/trail/trail.dart';
import 'package:flutter/material.dart';

class EducacaoViewModel extends ChangeNotifier {
  final TrailRepositoryImpl _trailRepository;

  EducacaoViewModel({required TrailRepositoryImpl trailRepository})
    : _trailRepository = trailRepository;

  List<Trail> _trails = [];
  List<Trail> get trails => _trails;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    try {
      _isLoading = true;
      notifyListeners();

      _trails = await _trailRepository.getAll();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
