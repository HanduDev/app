import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';

abstract class Toast {
  static void error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: Font.primary()),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void success(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Font.primary(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromARGB(255, 76, 176, 80),
      ),
    );
  }

  static void info(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: Font.primary()),
        backgroundColor: const Color.fromARGB(255, 129, 198, 255),
      ),
    );
  }
}
