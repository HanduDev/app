import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/lottie/working.json',
          repeat: true,
          width: double.infinity,
        ),
        const SizedBox(height: 16),
        Text(
          'plano_de_estudos.working'.i18n(),
          textAlign: TextAlign.center,
          style: Font.primary(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'plano_de_estudos.almost_done'.i18n(),
          textAlign: TextAlign.center,
          style: Font.primary(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
