import 'package:flutter/material.dart';

abstract class NotifierImpl extends ChangeNotifier {
  void setError(String message);
  void clearError();
}

class Notifier extends NotifierImpl {
  String? _message;
  String? get message => _message;

  @override
  void setError(String message) {
    _message = message;
    notifyListeners();
  }

  @override
  void clearError() {
    _message = null;
    notifyListeners();
  }
}
