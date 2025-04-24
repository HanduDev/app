import 'package:app/data/repositories/trail/trail_repository.dart';
import 'package:app/helpers/errors.dart';
import 'package:app/models/trail/trail_request.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_multiple_controller.dart';
import 'package:flutter/material.dart';

class FormsContainerViewModel extends ChangeNotifier {
  final TrailRepositoryImpl _trailRepository;
  bool isLoading = false;
  String errorText = "";

  FormsContainerViewModel({required TrailRepositoryImpl trailRepository})
    : _trailRepository = trailRepository;

  TextEditingController theme = TextEditingController();
  DropdownButtonController languageController = DropdownButtonController();
  DropdownMultipleController developController = DropdownMultipleController();
  DropdownMultipleController themesController = DropdownMultipleController();
  DropdownButtonController levelController = DropdownButtonController();
  DropdownButtonController timeToLearnController = DropdownButtonController();
  DropdownButtonController timeToStudyController = DropdownButtonController();

  int _currentIndex = 0;
  final int _totalSteps = 6;

  final List<String> themes = [
    "Música",
    "Entretenimento",
    "Esportes",
    "Moda e Beleza",
    "Tecnologia",
    "Programação",
    "Viagem",
    "Anime",
    "Profissão",
    "Família",
  ];

  final List<String> levels = ["Iniciante", "Intermediário", "Avançado"];

  final List<String> timeToLearn = [
    "1 mês",
    "2 meses",
    "3 meses",
    "4 meses",
    "5 meses",
    "6 meses",
    "7 meses",
    "8 meses",
    "9 meses",
    "10 meses",
    "11 meses",
    "12 meses",
  ];

  final List<String> timeToStudy = [
    "10 minutos",
    "20 minutos",
    "30 minutos",
    "40 minutos",
    "50 minutos",
    "1 hora ou mais",
  ];

  bool get isLastStep => _currentIndex + 1 == _totalSteps;
  int get currentIndex => _currentIndex;
  int get totalSteps => _totalSteps;

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
          language: languageController.value['countryCode'],
          developments: developController.valuesAsString,
          themes: themesController.valuesAsString,
          level: levelController.value,
          timeToLearn: timeToLearnController.value,
          timeToStudy: timeToStudyController.value,
        ),
      );
    } catch (e) {
      errorText = getErrorMessage(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
