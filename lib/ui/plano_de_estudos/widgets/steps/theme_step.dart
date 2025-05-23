import 'package:app/ui/core/shared/selectable_grid/selectable_grid.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_controller.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_model.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class ThemeStep extends StatelessWidget {
  ThemeStep({super.key});

  final List<String> _themes = [
    "music",
    "entertainment",
    "sports",
    "fashion_and_beauty",
    "technology",
    "programming",
    "travel",
    "anime",
    "profession",
    "family",
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
                "plano_de_estudos.steps.themes.options.$element".i18n();
            return SelectableGridModel(value: label, label: label);
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
