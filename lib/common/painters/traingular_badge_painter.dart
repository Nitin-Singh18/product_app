import 'package:flutter/material.dart';

class TriangularBadgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    final path = Path();
    const radius = Radius.circular(8);

    path.moveTo(0, 0);
    path.lineTo(size.width * 0.8, 0);
    path.arcToPoint(Offset(size.width, size.height * 0.2), radius: radius);
    path.lineTo(size.width, size.height * 0.5);
    path.arcToPoint(Offset(size.width * 0.9, size.height * 0.7),
        radius: radius);
    path.lineTo(size.width * 0.6, size.height * 0.9);
    path.arcToPoint(Offset(size.width * 0.5, size.height * 0.9),
        radius: radius);
    path.lineTo(size.width * 0.1, size.height * 0.7);
    path.arcToPoint(Offset(0, size.height * 0.5), radius: radius);
    path.lineTo(0, size.height * 0.2);
    path.arcToPoint(Offset(size.width * 0.2, 0), radius: radius);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
