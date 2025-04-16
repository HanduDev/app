import 'package:app/providers/languages_provider.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatelessWidget {
  final double width;
  final void Function(Map<String, String>)? onChanged;
  final Map<String, String>? value;
  final DropdownButtonController controller;
  final String? Function(Map<String, String>?)? validator;

  const LanguageSelector({
    super.key,
    this.width = 158,
    this.onChanged,
    this.value,
    this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final languagesProvider =
        context.read<LanguagesProvider?>() ?? LanguagesProvider();

    return Dropdown<Map<String, String>>(
      data: languagesProvider.languages,
      onSelect: onChanged,
      width: width,
      value: value,
      controller: controller,
      validator: validator,
      leading:
          (value) => CountryFlag.fromLanguageCode(
            value['countryCode']!,
            height: 20,
            width: 30,
            shape: const RoundedRectangle(8),
          ),
      render: (value) {
        return Text(
          value['name']!,
          maxLines: 1,
          softWrap: false,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
