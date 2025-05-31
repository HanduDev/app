import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  final String _label;

  const FormLabel(String label, {super.key}) : _label = label;

  @override
  Widget build(BuildContext context) {
    return Text(
      _label,
      textAlign: TextAlign.center,
      style: Font.primary(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.primary500,
      ),
    );
  }
}
