import 'package:app/ui/core/shared/selectable_grid/selectable_grid.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_controller.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_model.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class TimeToStudyStep extends StatelessWidget {
  TimeToStudyStep({super.key});
  final List<String> _timeToStudy = [
    "5_min",
    "15_min",
    "30_min",
    "45_min",
    "1h",
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context
        .select<FormsContainerViewModel, SelectableGridController>(
          (value) => value.timeToStudyController,
        );

    return SelectableGrid(
      items:
          _timeToStudy.map((element) {
            final label =
                "plano_de_estudos.steps.time_to_study.options.$element".i18n();

            return SelectableGridModel(value: label, label: label);
          }).toList(),
      crossAxisCount: 1,
      childAspectRatio: 16 / 3,
      render: (item, isSelected, colorData) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              item.value,
              style: Font.primary(
                color: colorData.borderColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
      controller: controller,
    );
  }
}
