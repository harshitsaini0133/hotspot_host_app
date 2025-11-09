import 'package:flutter/material.dart';
import 'package:intern_assignment/core/app_color_pallete.dart';
import 'package:intern_assignment/feature/onboarding/ui/widgets/custom_painter.dart';

class CurvedProgressIndicator extends StatefulWidget {
  final double progress;
  final double height;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final Duration duration;

  const CurvedProgressIndicator({
    super.key,
    required this.progress,
    this.height = 12,
    this.color = AppColorPallete.primaryColor,
    this.backgroundColor = Colors.white24,
    this.strokeWidth = 2.5,
    this.duration = const Duration(milliseconds: 2000),
  });

  @override
  State<CurvedProgressIndicator> createState() =>
      _CurvedProgressIndicatorState();
}

class _CurvedProgressIndicatorState extends State<CurvedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(CurvedProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation =
          Tween<double>(begin: _animation.value, end: widget.progress).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => CustomPaint(
        painter: CurvedPainter(
          progress: _animation.value,
          color: widget.color,
          backgroundColor: widget.backgroundColor,
          strokeWidth: widget.strokeWidth,
        ),
        size: Size(double.infinity, widget.height),
      ),
    );
  }
}
