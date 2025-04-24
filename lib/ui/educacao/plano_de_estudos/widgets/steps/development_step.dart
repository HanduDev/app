import 'package:app/ui/core/shared/dropdown/dropdown_multiple.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_multiple_controller.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_multiple_model.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/educacao/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DevelopmentStep extends StatefulWidget {
  const DevelopmentStep({super.key});

  @override
  State<DevelopmentStep> createState() => _DevelopmentStepState();
}

class _DevelopmentStepState extends State<DevelopmentStep> {
  final List<Map<String, String>> _developments = [
    {"icon": "assets/images/icons/leitura.svg", "name": "Leitura"},
    {"icon": "assets/images/icons/escrita.svg", "name": "Escrita"},
    {"icon": "assets/images/icons/escuta.svg", "name": "Escuta"},
    {"icon": "assets/images/icons/falando.svg", "name": "Fala"},
  ];

  @override
  Widget build(BuildContext context) {
    final developmentController = context
        .select<FormsContainerViewModel, DropdownMultipleController>((value) {
          return value.developController;
        });

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _developments.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final value = _developments[index];
        bool isSelected = developmentController.values.any((element) {
          return element.id == value["name"];
        });

        return GestureDetector(
          onTap: () {
            setState(() {
              developmentController.toggle(
                DropdownMultipleModel(id: value['name']!, name: value['name']!),
              );
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(value['icon']!, width: 36, height: 36),
                const SizedBox(width: 12),
                Text(
                  value['name']!,
                  style: Font.primary(
                    color: isSelected ? AppColors.primary500 : AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
