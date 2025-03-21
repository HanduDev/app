import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0.1, 1.5),
            colors: <Color>[AppColors.primary500, AppColors.primary100],
          ),
        ),
        child: child,
      ),
    );
  }
}
