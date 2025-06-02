import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary100 = Color(0xFFC8C7DC);
  static const Color primary200 = Color(0xFF8989C2);
  static const Color primary300 = Color(0xFF7170B0);
  static const Color primary400 = Color(0xFF6665A7);
  static const Color primary500 = Color(0xFF5E5C9E);
  static const Color black = Color(0xFF4E4747);
  static const Color grey = Color(0xFF625D5D);
  static const Color lightGrey = Color(0xFFD5D5D5);
  static const Color white = Color(0xFFFFFFFF);
  static const Color overlayColor = Color(0xFFC7C7C7);
  static const Color transparent = Color(0x00000000);
  static const Color yellow = Color(0xFFFFAE00);
  static const Color disabledIcon = Color.fromARGB(255, 163, 160, 160);
  static const Color lightPurple = Color(0xFF9862DF);
  static const List<Color> progressGradient = [
    AppColors.lightPurple,
    Color(0xFFE3E3EF),
  ];
  static const Color error = Color(0xFFEA3A3A);
  static const Color errorLight = Color.fromARGB(255, 241, 247, 169);
  static const Color green = Color.fromARGB(255, 127, 212, 130);
}
