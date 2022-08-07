import 'package:flutter/material.dart';

class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.cyan
      ..strokeWidth = 15;

    var path = Path();

    //Primer curva
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.08,
        size.width * 0.5, size.height * 0.2);
    path.quadraticBezierTo(
        size.width * 0.25, size.height * 0.33, 0, size.height * 0.35);
    path.lineTo(0, 0);

    //Segunda Curva
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.38,
        size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.25, size.height * 0.63, 0, size.height * 0.65);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
