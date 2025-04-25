import 'package:app/models/language.dart';
import 'package:app/providers/languages_provider.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_controller.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_model.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/educacao/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageStep extends StatefulWidget {
  const LanguageStep({super.key});

  @override
  State<LanguageStep> createState() => _LanguageStepState();
}

class _LanguageStepState extends State<LanguageStep> {
  @override
  Widget build(BuildContext context) {
    final languages = context.select<LanguagesProvider, List<Language>>(
      (value) => value.languages,
    );
    final languageController = context
        .select<FormsContainerViewModel, SelectableGridController>(
          (value) => value.languageController,
        );

    return SelectableGrid(
      items:
          languages
              .map(
                (element) => SelectableGridModel(
                  value: element.code,
                  label: element.name,
                  icon: CountryFlag.fromLanguageCode(
                    element.code,
                    shape: const RoundedRectangle(8),
                    width: 45,
                    height: 30,
                  ),
                ),
              )
              .toList(),
      crossAxisCount: 3,
      validator: (value) {
        if (value.isEmpty) {
          return "Selecione pelo menos um idioma";
        }
        
        return null;
      },
      render: (item, isSelected) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            item.icon,
            const SizedBox(height: 8),
            Text(
              item.label,
              style: Font.primary(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.primary500 : AppColors.black,
              ),
            ),
          ],
        );
      },
      controller: languageController,
    );
  }
}
