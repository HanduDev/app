import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/core/themes/app_colors.dart';

class TextInput extends StatelessWidget {
  final void Function(String text) onChange;
  final FormFieldValidator<String>? validator;
  final String? label;
  final bool readOnly;
  final String? initialValue;
  final bool? loading;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? sufixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;

  const TextInput({
    super.key,
    required this.onChange,
    this.initialValue,
    this.readOnly = false,
    this.loading,
    this.label,
    this.obscureText = false,
    this.backgroundColor,
    this.textColor,
    this.prefixIcon,
    this.sufixIcon,
    this.validator,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChange,
      initialValue: initialValue,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: sufixIcon,
        contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary400, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: label,
        labelStyle: Font.primary(
          fontWeight: FontWeight.w400,
          color: AppColors.lightGrey,
        ),
        floatingLabelStyle: Font.primary(
          fontWeight: FontWeight.w500,
          color: AppColors.primary400,
        ),
      ),
    );
  }
}
