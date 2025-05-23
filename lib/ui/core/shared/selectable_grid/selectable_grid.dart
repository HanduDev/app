import 'package:app/ui/core/shared/selectable_grid/selectable_grid_color.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_controller.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_model.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class SelectableGrid extends StatefulWidget {
  final List<SelectableGridModel> items;
  final SelectableGridController controller;
  final Function(SelectableGridModel, bool, SelectableGridColor) render;
  final int crossAxisCount;
  final Color? selectedColor;
  final Color selectedBorderColor;
  final double childAspectRatio;
  final bool disabled;
  final String? Function(List<SelectableGridModel>)? validator;
  final SelectableGridColor Function(String)? onColorChange;

  const SelectableGrid({
    super.key,
    required this.items,
    required this.render,
    required this.controller,
    this.disabled = false,
    this.validator,
    this.childAspectRatio = 1.3,
    this.selectedColor,
    this.selectedBorderColor = AppColors.primary500,
    this.crossAxisCount = 3,
    this.onColorChange,
  });

  @override
  State<SelectableGrid> createState() => _SelectableGridState();
}

class _SelectableGridState extends State<SelectableGrid> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (unnusedValue) {
        if (widget.validator != null) {
          return widget.validator!(widget.controller.values);
        }

        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder:
          (field) => GridView.count(
            crossAxisCount: widget.crossAxisCount,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: widget.childAspectRatio,
            shrinkWrap: true,
            children: List.generate(widget.items.length, (index) {
              final value = widget.items[index];
              final isSelected = widget.controller.isSelected(value);
              final colorData =
                  widget.onColorChange != null
                      ? widget.onColorChange!(value.value)
                      : SelectableGridColor(
                        backgroundColor:
                            isSelected
                                ? widget.selectedColor ??
                                    AppColors.lightPurple.withValues(alpha: 0.3)
                                : AppColors.white,
                        borderColor:
                            isSelected
                                ? widget.selectedBorderColor
                                : AppColors.grey,
                      );

              return GestureDetector(
                onTap:
                    widget.disabled
                        ? null
                        : () {
                          setState(() {
                            widget.controller.toggle(value);
                          });
                        },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colorData.borderColor, width: 2),
                    color: colorData.backgroundColor,
                  ),
                  child: widget.render(value, isSelected, colorData),
                ),
              );
            }),
          ),
    );
  }
}
