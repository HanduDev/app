import 'package:app/ui/core/shared/selectable_grid/selectable_grid.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_controller.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_model.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/study_plan/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class ThemeStep extends StatelessWidget {
  ThemeStep({super.key});

  final List<Map<String, dynamic>> _themes = [
    {"value": "music", "icon": Icons.music_note},
    {"value": "entertainment", "icon": Icons.movie},
    {"value": "sports", "icon": Icons.sports_soccer},
    {"value": "fashion_and_beauty", "icon": Icons.face},
    {"value": "technology", "icon": Icons.memory},
    {"value": "programming", "icon": Icons.code},
    {"value": "travel", "icon": Icons.flight},
    {"value": "anime", "icon": Icons.animation},
    {"value": "profession", "icon": Icons.work},
    {"value": "family", "icon": Icons.family_restroom},
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context
        .select<FormsContainerViewModel, SelectableGridController>(
          (value) => value.themesController,
        );

    return SelectableGrid(
      items:
          _themes.map((element) {
            final label =
                "plano_de_estudos.steps.themes.options.${element['value']}"
                    .i18n();

            return SelectableGridModel(
              value: label,
              label: label,
              icon: Icon(element['icon']),
            );
          }).toList(),
      crossAxisCount: 3,
      render: (item, isSelected, colorData) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            item.icon,
            const SizedBox(height: 8),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: Font.primary(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: colorData.borderColor,
              ),
            ),
          ],
        );
      },
      controller: controller,
    );
  }
}
