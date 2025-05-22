import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';

abstract class Toast {
  static void error(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      Row(
        children: [
          Icon(Icons.error_outline, color: Colors.white),
          SizedBox(width: 8),
          Expanded(child: Text(message, style: Font.primary())),
        ],
      ),
      const Color.fromARGB(255, 255, 102, 102),
    );
  }

  static void success(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      Row(
        children: [
          Icon(Icons.check_circle_outline, color: Colors.white),
          SizedBox(width: 8),
          Expanded(child: Text(message, style: Font.primary())),
        ],
      ),
      const Color.fromARGB(255, 76, 176, 80),
    );
  }

  static void info(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      Row(
        children: [
          Icon(Icons.info_outline, color: Colors.white),
          SizedBox(width: 8),
          Expanded(child: Text(message, style: Font.primary())),
        ],
      ),
      const Color.fromARGB(255, 129, 198, 255),
    );
  }

  static void _showSnackBar(
    BuildContext context,
    String message,
    Widget content,
    Color color,
  ) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        showCloseIcon: true,
        dismissDirection: DismissDirection.horizontal,
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white),
            SizedBox(width: 8),
            Expanded(child: Text(message, style: Font.primary())),
          ],
        ),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        margin: const EdgeInsets.all(32.0),
        behavior: SnackBarBehavior.floating,
        animation: CurvedAnimation(
          parent: AnimationController(
            vsync: Navigator.of(context),
            duration: const Duration(milliseconds: 300),
          )..forward(),
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
}
