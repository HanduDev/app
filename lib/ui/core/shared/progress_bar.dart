import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  final double height;
  final Color? emptyBackground;
  final Color? fullFillBackground;

  const ProgressBar({
    super.key,
    required this.value,
    this.emptyBackground,
    this.fullFillBackground,
    this.height = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final List<double> valueStop =
        value != 1.0 ? [value - 0.3, 1.0] : [value, 1.0];

    final background =
        value == 1 && fullFillBackground != null
            ? fullFillBackground
            : AppColors.progressGradient[0];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: emptyBackground ?? AppColors.primary400,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SizedBox(height: height),
            ),
            Container(
              width: constraints.maxWidth * value,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    background ?? AppColors.progressGradient[0],
                    AppColors.progressGradient[1],
                  ],
                  stops: valueStop,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SizedBox(height: height),
            ),
          ],
        );
      },
    );
  }
}
