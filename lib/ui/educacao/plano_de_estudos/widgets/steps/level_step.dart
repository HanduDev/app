import 'package:app/ui/core/shared/selectable_grid/selectable_grid.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_controller.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_model.dart';
import 'package:app/ui/educacao/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LevelStep extends StatelessWidget {
  LevelStep({super.key});
  final List<String> _levels = ["Iniciante", "Intermediário", "Avançado"];

  @override
  Widget build(BuildContext context) {
    final controller = context
        .select<FormsContainerViewModel, SelectableGridController>(
          (value) => value.levelController,
        );

    return SelectableGrid(
      items:
          _levels
              .map(
                (element) =>
                    SelectableGridModel(value: element, label: element),
              )
              .toList(),
      crossAxisCount: 1,
      childAspectRatio: 16 / 3,
      render: (item, isSelected) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 12),
            Text(
              item.value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        );
      },
      controller: controller,
    );
  }
}
