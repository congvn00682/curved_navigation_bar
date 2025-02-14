import 'package:flutter/material.dart';

class NavCustomPainterBlur extends CustomPainter {
  late double loc;
  late double s;
  Color? color;
  TextDirection textDirection;

  NavCustomPainterBlur(
      double startingLoc, int itemsLength, this.color, this.textDirection) {
    final span = 1.0 / itemsLength;
    s = 0.2;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
    color = Color(0xff7E79C1).withOpacity(0.16);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color!
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo((loc - 0.05) * size.width, 0) //2
      ..cubicTo(
        (loc + s * 0.20) * size.width,
        size.height * 0.05,
        loc * size.width,
        size.height * 0.38, // 3
        (loc + s * 0.50) * size.width,
        size.height * 0.41, // 1
      )
      ..cubicTo(
        (loc + s) * size.width,
        size.height * 0.38, // 3
        (loc + s - s * 0.20) * size.width,
        size.height * 0.05,
        (loc + s + 0.05) * size.width, //2
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawShadow(path, Color(0xff7E79C1).withOpacity(0.16), 0.0, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
