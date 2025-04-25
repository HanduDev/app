import 'package:app/ui/core/shared/selectable_grid/selectable_grid_model.dart';
import 'package:flutter/material.dart';

class SelectableGridController extends ChangeNotifier {
  final List<SelectableGridModel> _values;
  final bool isMultiple;

  SelectableGridController({
    List<SelectableGridModel>? initialValues,
    this.isMultiple = false,
  }) : _values = initialValues ?? [];

  List<SelectableGridModel> get values => _values;
  SelectableGridModel? get value => _values.isNotEmpty ? _values.first : null;

  String valuesAsString() {
    return _values.map((value) => value.value).toList().join(", ");
  }

  toggle(SelectableGridModel newValue) {
    if (!isMultiple) {
      _values.clear();
      _values.add(newValue);
      notifyListeners();
      return;
    }

    if (_values.any((value) => value == newValue)) {
      _values.removeWhere((value) => value.value == newValue.value);
    } else {
      _values.add(newValue);
    }

    notifyListeners();
  }

  bool isSelected(SelectableGridModel value) {
    return _values.any((item) => item.value == value.value);
  }
}
