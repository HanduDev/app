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

  toggle(DropdownMultipleModel? newValue) {
    if (newValue == null) return;

    if (_values.contains(newValue)) {
      _values.remove(newValue);
    } else {
      _values.add(newValue);
    }

    notifyListeners();
  }
}
