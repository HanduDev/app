import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/secondary_button.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control_item.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class SegmentedControl extends StatefulWidget {
  final int? initialIndex;
  final List<SegmentedControlItem> items;
  final void Function(String key) onChange;

  const SegmentedControl({
    super.key,
    required this.onChange,
    required this.items,
    this.initialIndex,
  });

  @override
  State<SegmentedControl> createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      decoration: BoxDecoration(
        color: AppColors.primary400,
        borderRadius: BorderRadius.all(Radius.circular(999)),
        boxShadow: [
          BoxShadow(blurRadius: 8, spreadRadius: -2, color: AppColors.black),
        ],
      ),
      child: Row(
        children:
            widget.items.asMap().entries.map((entry) {
              int index = entry.key;
              Icon? icon =
                  entry.value.icon != null
                      ? Icon(entry.value.icon, size: 20.0)
                      : null;

              bool isSelected = index == _index;

              return Expanded(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  transitionBuilder:
                      (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                  child:
                      isSelected
                          ? SecondaryButton(
                            key: ValueKey<int>(_index),
                            text: entry.value.text,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            fontSize: 14,
                            rounded: true,
                            leftIcon: icon,
                            elevation: 0,
                            onPressed: () {},
                          )
                          : PrimaryButton(
                            key: ValueKey<int>(index),
                            text: entry.value.text,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            leftIcon: icon,
                            fontSize: 14,
                            rounded: true,
                            elevation: 0,
                            onPressed: () {
                              widget.onChange(entry.value.key);
                              setState(() {
                                _index = index;
                              });
                            },
                          ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
