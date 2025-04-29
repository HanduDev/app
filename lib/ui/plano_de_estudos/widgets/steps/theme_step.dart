import 'package:app/ui/core/shared/selectable_grid/selectable_grid.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_controller.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_model.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeStep extends StatelessWidget {
  ThemeStep({super.key});

  final List<String> _themes = [
    "Música",
    "Entretenimento",
    "Esportes",
    "Moda e Beleza",
    "Tecnologia",
    "Programação",
    "Viagem",
    "Anime",
    "Profissão",
    "Família",
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context
        .select<FormsContainerViewModel, SelectableGridController>(
          (value) => value.themesController,
        );

    return SelectableGrid(
      items:
          _themes
              .map(
                (element) =>
                    SelectableGridModel(value: element, label: element),
              )
              .toList(),
      crossAxisCount: 3,
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
      controller: controller,
    );
  }
}
