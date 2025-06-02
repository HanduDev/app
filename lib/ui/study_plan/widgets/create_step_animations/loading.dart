import 'dart:async';

import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final int estimatedTime = 105;
  int currentTime = 105;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        return;
      }

      setState(() {
        currentTime--;
      });
    });
  }

  String _getTime() {
    if (currentTime < 0) {
      final timeToConsider = currentTime * -1;

      final minutes = timeToConsider ~/ 60;
      final seconds = timeToConsider % 60;
      return '-${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }

    final minutes = currentTime ~/ 60;
    final seconds = currentTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

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
        const SizedBox(height: 16),
        Text(
          "Tempo estimado: ${_getTime()}",
          textAlign: TextAlign.center,
          style: Font.primary(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: currentTime < 0 ? AppColors.yellow : AppColors.white,
          ),
        ),

        const SizedBox(height: 16),

        if (currentTime < 0)
          Text(
            'plano_de_estudos.longer_than_expected'.i18n(),
            textAlign: TextAlign.center,
            style: Font.primary(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.yellow,
            ),
          ),
      ],
    );
  }
}
