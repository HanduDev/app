import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ChatTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = AppColors.primary400
          ..style = PaintingStyle.fill;

    Path path =
        Path()
          ..moveTo(size.width, size.height * 2) // Top point of the triangle
          ..lineTo(0, size.height) // Bottom-left point
          ..lineTo(size.width, size.height) // Bottom-right point
          ..close();

    canvas.save();
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
