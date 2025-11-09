import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intern_assignment/core/app_color_pallete.dart';

class CustomButton extends StatelessWidget {
  final String btnname;
  final VoidCallback? onPressed;
  final double borderRadius;
  final Widget? icon;
  final double height;

  const CustomButton({
    super.key,
    required this.btnname,
    required this.onPressed,
    this.borderRadius = 8.0,
    this.icon,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onPressed == null ? 0.5 : 1.0,
      child: GestureDetector(
        onTap: onPressed,
        child: CustomPaint(
          painter: GradientBorderPainter(
            gradient: AppColorPallete.borderGradient,
            strokeWidth: 0.8,
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  height: height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppColorPallete.buttonGradient,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          btnname,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                        if (icon != null) ...[
                          const SizedBox(width: 8),
                          icon!,
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final Gradient gradient;
  final double strokeWidth;
  final double borderRadius;

  GradientBorderPainter({
    required this.gradient,
    required this.strokeWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final RRect rRect =
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(rect);

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant GradientBorderPainter oldDelegate) {
    return oldDelegate.gradient != gradient ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.borderRadius != borderRadius;
  }
}
