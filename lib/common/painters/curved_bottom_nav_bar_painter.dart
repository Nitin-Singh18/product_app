import 'package:flutter/material.dart';

import '../../theme/app_color.dart';
import '../constants.dart';

class CurvedBottomNavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.green
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 32)
      // start curve
      ..arcToPoint(Offset(size.width * 0.06, 10),
          radius: const Radius.circular(borderRadiusLarge))
      ..lineTo(size.width * 0.38, 1)
      // left edge for curve
      ..arcToPoint(Offset(size.width * 0.4, 6),
          radius: const Radius.circular(8))
      // under curve
      ..arcToPoint(Offset(size.width * 0.6, 6),
          radius: const Radius.circular(40), clockwise: false)
      // right edge for curve
      ..arcToPoint(Offset(size.width * 0.62, 1),
          radius: const Radius.circular(8))
      ..lineTo(size.width * 0.94, 10)
      // end curve
      ..arcToPoint(Offset(size.width, 32),
          radius: const Radius.circular(borderRadiusLarge))
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
