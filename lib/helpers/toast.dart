import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';

abstract class Toast {
  static void error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 8),
            Expanded(child: Text(message, style: Font.primary())),
          ],
        ),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        margin: const EdgeInsets.all(32.0),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void success(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: Font.primary(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 76, 176, 80),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        margin: const EdgeInsets.all(32.0),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void info(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white),
            SizedBox(width: 8),
            Expanded(child: Text(message, style: Font.primary())),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 129, 198, 255),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        margin: const EdgeInsets.all(32.0),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
