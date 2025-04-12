import 'package:app/ui/core/shared/dropdown/dropdown_multiple_model.dart';
import 'package:flutter/material.dart';

class DropdownMultipleController extends ChangeNotifier {
  final List<DropdownMultipleModel> _values;
  final Function(DropdownMultipleModel)? onChanged;
  final bool isRequired;

  DropdownMultipleController({
    List<DropdownMultipleModel>? initialValues,
    this.onChanged,
    this.isRequired = false,
  }) : _values = initialValues ?? [];

  List<DropdownMultipleModel> get values => _values;

  toggle(DropdownMultipleModel newValue) {
    if (_values.any((value) => value.id == newValue.id)) {
      _values.removeWhere((value) => value.id == newValue.id);
    } else {
      _values.add(newValue);
    }

    notifyListeners();
  }

  List<String> get valuesAsString {
    return _values.map((value) => value.name).toList();
  }
}
