import 'package:app/models/language.dart';
import 'package:app/providers/languages_provider.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatelessWidget {
  final double width;
  final void Function(Language)? onChanged;
  final Language? value;
  final DropdownButtonController controller;
  final String? Function(Language?)? validator;
  final Language? initialValue;

  const LanguageSelector({
    super.key,
    this.width = 158,
    this.onChanged,
    this.value,
    this.validator,
    this.initialValue,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final languages = context.select<LanguagesProvider, List<Language>>(
      (provider) => provider.languages,
    );

    if (initialValue != null) {
      controller.value = initialValue;
    }

    return Dropdown<Language>(
      data: languages,
      onSelect: onChanged,
      width: width,
      value: value,
      controller: controller,
      validator: validator,
      leading:
          (value) => CountryFlag.fromLanguageCode(
            value.code,
            height: 20,
            width: 30,
            shape: const RoundedRectangle(8),
          ),
      render: (value) {
        return Text(
          value.name,
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
