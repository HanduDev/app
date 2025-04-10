import 'package:flutter/material.dart';

class ChatTriangle extends CustomPainter {
  final Color color;
  final double borderRadius;

  const ChatTriangle({this.color = Colors.black, this.borderRadius = 6.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    final p1 = Offset(0, size.height);
    final p2 = Offset(size.width, size.height);
    final p3 = Offset(0, 0);

    // Cálculo dos pontos arredondados
    Offset offset(Offset from, Offset to, double radius) {
      final direction = (to - from).direction;
      return from + Offset.fromDirection(direction, radius);
    }

    final p1a = offset(p1, p2, borderRadius);
    final p1b = offset(p1, p3, borderRadius);
    final p2a = offset(p2, p3, borderRadius);
    final p2b = offset(p2, p1, borderRadius);
    final p3a = offset(p3, p1, borderRadius);
    final p3b = offset(p3, p2, borderRadius);

    path.moveTo(p1a.dx, p1a.dy);
    path.quadraticBezierTo(p1.dx, p1.dy, p1b.dx, p1b.dy);
    path.lineTo(p3a.dx, p3a.dy);
    path.quadraticBezierTo(p3.dx, p3.dy, p3b.dx, p3b.dy);
    path.lineTo(p2a.dx, p2a.dy);
    path.quadraticBezierTo(p2.dx, p2.dy, p2b.dx, p2b.dy);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
