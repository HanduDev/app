import 'package:app/ui/educacao/plano_de_estudos/controllers/first_step_form_controller.dart';
import 'package:app/ui/educacao/plano_de_estudos/controllers/second_step_form_controller.dart';
import 'package:flutter/material.dart';

class FormsContainerViewModel extends ChangeNotifier {
  SecondStepFormController secondStepFormController =
      SecondStepFormController();

  FirstStepFormController firstStepFormController = FirstStepFormController();

  int _currentIndex = 0;
  final int _totalSteps = 2;

  final Map<int, String> _formTitles = {
    0: 'Dados Pessoais',
    1: 'Dados de Contato',
  };

  int get currentIndex =>
      _currentIndex == _totalSteps ? _totalSteps : _currentIndex + 1;
  int get totalSteps => _totalSteps;

  String get currentTitle => _formTitles[_currentIndex] ?? '';

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (_currentIndex < _totalSteps - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }
}
