import 'package:app/ui/core/shared/selectable_grid/selectable_grid.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_controller.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_model.dart';
import 'package:app/ui/educacao/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeToStudyStep extends StatelessWidget {
  TimeToStudyStep({super.key});
  final List<String> _timeToStudy = [
    "5 min/dia",
    "15 min/dia",
    "30 min/dia",
    "45 min/dia",
    "1h/dia",
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context
        .select<FormsContainerViewModel, SelectableGridController>(
          (value) => value.timeToStudyController,
        );

    return SelectableGrid(
      items:
          _timeToStudy
              .map(
                (element) =>
                    SelectableGridModel(value: element, label: element),
              )
              .toList(),
      crossAxisCount: 1,
      childAspectRatio: 16 / 3,
      render: (item, isSelected) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
