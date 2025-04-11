import 'package:flutter/material.dart';

class DropdownButtonController<T> extends ChangeNotifier {
  T? _value;
  final Function(T)? onChanged;
  final bool isRequired;

  DropdownButtonController({
    T? initialValue,
    this.onChanged,
    this.isRequired = false,
  }) : _value = initialValue;

  T? get value => _value;

  set value(T? newValue) {
    _value = newValue;
    notifyListeners();

    if (onChanged != null && newValue != null) {
      onChanged!(newValue);
    }
  }
}
