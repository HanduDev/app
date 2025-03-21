import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
