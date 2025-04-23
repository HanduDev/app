import 'package:app/models/language.dart';
import 'package:app/providers/languages_provider.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
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
    final languagesProvider = context.select<LanguagesProvider, List<Language>>(
      (value) => value.languages,
    );
    final languageController = context
        .select<FormsContainerViewModel, DropdownButtonController>(
          (value) => value.languageController,
        );

    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      childAspectRatio: 1.3,
      shrinkWrap: false,
      children: List.generate(languagesProvider.length, (index) {
        final value = languagesProvider[index];
        final languageControllerValue = languageController.value;

        bool isSelected =
            languageControllerValue != null &&
            value.code == languageControllerValue.code;

        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                languageController.value = null;
              } else {
                languageController.value = Language(
                  name: languagesProvider[index].name,
                  code: languagesProvider[index].code,
                );
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? AppColors.primary500 : AppColors.lightGrey,
                width: 2,
              ),
              color:
                  isSelected
                      ? AppColors.lightPurple.withValues(alpha: 0.3)
                      : AppColors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CountryFlag.fromLanguageCode(
                  languagesProvider[index].code,
                  shape: const RoundedRectangle(8),
                  width: 45,
                  height: 30,
                ),
                const SizedBox(height: 8),
                Text(
                  languagesProvider[index].name,
                  style: Font.primary(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? AppColors.primary500 : AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
