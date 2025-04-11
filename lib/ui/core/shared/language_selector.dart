import 'package:app/providers/languages_provider.dart';
import 'package:app/ui/core/shared/dropdown_button.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatelessWidget {
  final double width;
  final void Function(Map<String, String>)? onChanged;
  final Map<String, String>? value;

  const LanguageSelector({
    super.key,
    this.width = 158,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    if (Provider.of<LanguagesProvider?>(context, listen: false) == null) {
      return Dropdown(
        data: LanguagesProvider().languages,
        onSelect: onChanged,
        width: width,
        value: value,
        leading:
            (value) => CountryFlag.fromLanguageCode(
              value['countryCode']!,
              height: 20,
              width: 30,
            ),
        render: (value) {
          return Text(value['name']!);
        },
      );
    }

    return Consumer<LanguagesProvider>(
      builder: (context, languagesProvider, child) {
        return Dropdown<Map<String, String>>(
          data: languagesProvider.languages,
          onSelect: onChanged,
          width: width,
          value: value,
          leading:
              (value) => CountryFlag.fromLanguageCode(
                value['countryCode']!,
                height: 20,
                width: 30,
              ),
          render: (value) {
            return Text(value['name']!);
          },
        );
      },
    );
  }
}
