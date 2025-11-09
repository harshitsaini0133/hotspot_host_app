import 'dart:math';

import 'package:flutter/material.dart';

class CurvedPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  CurvedPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final foregroundPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    _drawWave(canvas, size, backgroundPaint, size.width);

    final totalWidth = size.width * progress;
    _drawWave(canvas, size, foregroundPaint, totalWidth);
  }

  void _drawWave(Canvas canvas, Size size, Paint paint, double width) {
    if (width <= 0) return;
    final wavePath = Path();
    const waveHeight = 5.0;
    const waveLength = 20.0;

    for (double x = 0; x <= width; x++) {
      final y = sin((x / waveLength) * 2 * pi) * waveHeight + size.height / 2;
      if (x == 0) {
        wavePath.moveTo(x, y);
      } else {
        wavePath.lineTo(x, y);
      }
    }
    canvas.drawPath(wavePath, paint);
  }

  @override
  bool shouldRepaint(covariant CurvedPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.color != color ||
      oldDelegate.backgroundColor != oldDelegate.backgroundColor ||
      oldDelegate.strokeWidth != strokeWidth;
}
