import 'package:flutter/material.dart';

class SelectableGridModel {
  final String value;
  final String label;
  final Widget icon;
  final bool isVertical;

  SelectableGridModel({
    required this.value,
    required this.label,
    this.icon = const SizedBox.shrink(),
    this.isVertical = false,
  });
}
