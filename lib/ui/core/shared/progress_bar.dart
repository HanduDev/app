import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  final double height;
  final Color? backgroundColor;

  const ProgressBar({
    super.key,
    required this.value,
    this.backgroundColor,
    this.height = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final List<double> valueStop = [value, 1];

    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.primary300,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SizedBox(height: height),
        ),
        Container(
          width: MediaQuery.of(context).size.width * value,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.progressGradient,
              stops: valueStop,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SizedBox(height: height),
        ),
      ],
    );
  }
}
