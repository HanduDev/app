import 'package:app/ui/core/shared/selectable_grid/selectable_grid.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_controller.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_model.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/study_plan/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class DevelopmentStep extends StatefulWidget {
  const DevelopmentStep({super.key});

  @override
  State<DevelopmentStep> createState() => _DevelopmentStepState();
}

class _DevelopmentStepState extends State<DevelopmentStep> {
  final List<Map<String, String>> _developments = [
    {"icon": "assets/images/icons/leitura.svg", "value": 'reading'},
    {"icon": "assets/images/icons/escrita.svg", "value": 'writing'},
    {"icon": "assets/images/icons/escuta.svg", "value": 'listening'},
    {"icon": "assets/images/icons/falando.svg", "value": 'speaking'},
  ];

  @override
  Widget build(BuildContext context) {
    final developmentController = context
        .select<FormsContainerViewModel, SelectableGridController>((value) {
          return value.developController;
        });

    return SelectableGrid(
      items:
          _developments
              .map(
                (element) => SelectableGridModel(
                  value: element["value"]!,
                  label:
                      "plano_de_estudos.steps.development.options.${element["value"]}"
                          .i18n(),
                  icon: SvgPicture.asset(
                    element["icon"]!,
                    width: 36,
                    height: 36,
                  ),
                ),
              )
              .toList(),
      crossAxisCount: 1,
      controller: developmentController,
      childAspectRatio: 16 / 3,
      validator: (value) {
        if (value.isEmpty) {
          return "plano_de_estudos.steps.development.select_one_at_least"
              .i18n();
        }

        return null;
      },
      render: (item, isSelected, colorData) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 12),
            item.icon,
            const SizedBox(width: 12),
            Text(
              item.label,
              style: Font.primary(
                color: colorData.borderColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}
