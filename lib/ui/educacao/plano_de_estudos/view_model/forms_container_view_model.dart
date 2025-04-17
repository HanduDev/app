import 'package:app/data/repositories/trail/trail_repository.dart';
import 'package:app/helpers/errors.dart';
import 'package:app/models/trail/trail_request.dart';
import 'package:app/ui/educacao/plano_de_estudos/controllers/first_step_form_controller.dart';
import 'package:app/ui/educacao/plano_de_estudos/controllers/second_step_form_controller.dart';
import 'package:flutter/material.dart';

class FormsContainerViewModel extends ChangeNotifier {
  final TrailRepositoryImpl _trailRepository;
  bool isLoading = false;
  String errorText = "";

  FormsContainerViewModel({required TrailRepositoryImpl trailRepository})
    : _trailRepository = trailRepository;

  SecondStepFormController secondStepFormController =
      SecondStepFormController();

  FirstStepFormController firstStepFormController = FirstStepFormController();

  int _currentIndex = 0;
  final int _totalSteps = 2;

  final Map<int, String> _formTitles = {
    0: 'Suas preferências',
    1: 'Sobre o plano',
  };

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
  final List<String> developments = ["Fala", "Leitura", "Escrita", "Escuta"];

  bool get isLastStep => _currentIndex + 1 == _totalSteps;
  int get currentIndex => _currentIndex;
  int get totalSteps => _totalSteps;
  String get currentTitle => _formTitles[_currentIndex] ?? '';

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  bool validate() {
    if (_currentIndex == 0) {
      return firstStepFormController.validate();
    }

    if (_currentIndex == 1) {
      return secondStepFormController.validate();
    }

    return false;
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
          language:
              firstStepFormController.languageController.value['countryCode'],
          developments:
              firstStepFormController.developmentsController.valuesAsString,
          themes: firstStepFormController.themesController.valuesAsString,
          level: secondStepFormController.level.value,
          timeToLearn: secondStepFormController.timeToLearn.value,
          timeToStudy: secondStepFormController.timeToStudy.value,
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
