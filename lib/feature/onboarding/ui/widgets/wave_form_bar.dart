import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intern_assignment/core/app_color_pallete.dart';

class WaveformBar extends StatefulWidget {
  final bool isPlaying;
  final bool isRecording;
  final int barCount;
  final double maxBarHeight;

  const WaveformBar({
    super.key,
    this.isPlaying = false,
    this.isRecording = false,
    this.barCount = 50,
    this.maxBarHeight = 25.0,
  });

  @override
  State<WaveformBar> createState() => _WaveformBarState();
}

class _WaveformBarState extends State<WaveformBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<double> _startHeights;
  late List<double> _endHeights;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _startHeights = _generateRandomHeights();
    _endHeights = _generateRandomHeights();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _startHeights = _endHeights;
            _endHeights = _generateRandomHeights();
            _controller.forward(from: 0.0);
          });
        }
      });

    if (widget.isPlaying || widget.isRecording) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant WaveformBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.barCount != oldWidget.barCount) {
      _startHeights = _generateRandomHeights();
      _endHeights = _generateRandomHeights();
    }

    if ((widget.isPlaying || widget.isRecording) && !_controller.isAnimating) {
      _controller.forward();
    } else if (!(widget.isPlaying || widget.isRecording) &&
        _controller.isAnimating) {
      _controller.stop(canceled: false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<double> _generateRandomHeights() {
    return List.generate(
      widget.barCount,
      (index) => _random.nextDouble() * widget.maxBarHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(widget.barCount, (index) {
        final startHeight = _startHeights[index];
        final endHeight = _endHeights[index];
        final height =
            lerpDouble(startHeight, endHeight, _controller.value) ?? 0.0;
        return Container(
          width: 2.5,
          height: height.clamp(2.0, widget.maxBarHeight),
          margin: const EdgeInsets.symmetric(horizontal: 1.5),
          color: AppColorPallete.text2,
        );
      }),
    );
  }
}
