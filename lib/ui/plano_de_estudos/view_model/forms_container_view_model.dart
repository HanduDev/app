import 'package:app/data/repositories/trail/trail_repository.dart';
import 'package:app/helpers/errors.dart';
import 'package:app/models/trail/trail.dart';
import 'package:app/models/trail/trail_request.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_controller.dart';
import 'package:flutter/material.dart';

class FormsContainerViewModel extends ChangeNotifier {
  final TrailRepositoryImpl _trailRepository;

  bool isLoading = false;
  String errorText = "";
  Trail? _trail;

  FormsContainerViewModel({required TrailRepositoryImpl trailRepository})
    : _trailRepository = trailRepository;

  TextEditingController theme = TextEditingController();
  SelectableGridController languageController = SelectableGridController();
  SelectableGridController developController = SelectableGridController(
    isMultiple: true,
  );
  SelectableGridController levelController = SelectableGridController();
  SelectableGridController themesController = SelectableGridController(
    isMultiple: true,
  );
  SelectableGridController timeToStudyController = SelectableGridController();

  int _currentIndex = 0;
  final int _totalSteps = 5;

  final List<String> levels = ["Iniciante", "Intermediário", "Avançado"];

  bool get isLastStep => _currentIndex + 1 == _totalSteps;
  int get currentIndex => _currentIndex;
  int get totalSteps => _totalSteps;
  Trail? get trail => _trail;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    _currentIndex++;
    notifyListeners();
  }

  void previousPage() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  Future<void> onFinish() async {
    try {
      isLoading = true;
      errorText = '';
      notifyListeners();

      await _trailRepository.create(
        TrailRequest(
          language: languageController.value!.value,
          developments: developController.values.map((e) => e.value).toList(),
          themes: developController.values.map((e) => e.value).toList(),
          level: levelController.value!.value,
          timeToLearn: "12 meses",
          timeToStudy: timeToStudyController.value!.value,
        ),
      );
    } catch (e) {
      errorText = getErrorMessage(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setTrail(Trail trail) {
    _trail = trail;
    notifyListeners();
  }
}
