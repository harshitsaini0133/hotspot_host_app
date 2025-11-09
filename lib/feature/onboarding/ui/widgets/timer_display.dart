import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:intern_assignment/core/app_color_pallete.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({
    super.key,
    required this.seconds,
    this.fontcolor = AppColorPallete.primaryColor,
  });

  final int seconds;
  final Color? fontcolor;

  @override
  Widget build(BuildContext context) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    final textStyle = TextStyle(
      color: fontcolor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

    return Row(
      children: [
        AnimatedFlipCounter(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
          value: minutes,
          textStyle: textStyle,
          prefix: minutes < 10 ? "0" : "",
        ),
        Text(":", style: textStyle),
        AnimatedFlipCounter(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
          value: remainingSeconds,
          textStyle: textStyle,
          prefix: remainingSeconds < 10 ? "0" : "",
        ),
      ],
    );
  }
}
