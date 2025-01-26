import 'package:flutter/material.dart';
import 'dart:math';

class CustomGraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('График функции'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(750, 300),
          painter: SineWavePainter(),
        ),
      ),
    );
  }
}

class SineWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final axisPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), axisPaint);
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), axisPaint);

    // Рисуем пинусоиду
    final path = Path();
    final double amplitude = size.height / 4;
    const double frequency = 2;
    const double step = 1;

    for (double x = 0; x <= size.width; x += step) {
      final y = amplitude * sin((x / size.width) * 2 * pi * frequency);
      final offsetX = x;
      final offsetY = size.height / 2 - y;
      if (x == 0) {
        path.moveTo(offsetX, offsetY);
      } else {
        path.lineTo(offsetX, offsetY);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
