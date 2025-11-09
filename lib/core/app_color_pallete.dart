// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppColorPallete {
  static const Color primaryColor = Color(0xFF9196FF);
  static const Color secondaryColor = Color(0xFF5961FF);
  static const Color positive = Color(0xff63FF60);
  static const Color negative = Color(0xffC22743);

  // text color
  static const Color text1 = Color(0xFFffffff);
  static const Color text2 = Color(0xB8FFFFFF);
  static const Color text3 = Color(0x7AFFefff);
  static const Color text4 = Color(0x3DFFFFFF);
  static const Color text5 = Color(0x3DFFFFFF);
  //base color
  static const Color base2 = Color(0xFF101010);
  static const Color base3 = Color(0xFF151515);
  // surface color
  static const Color surfaceWhite1 = Color(0x05FFFFFF);
  static const Color surfaceWhite2 = Color(0xFFF2F2F2);
  static const Color surfaceBlack1 = Color(0x101010E6);
  static const Color surfaceBlack2 = Color(0x101010B3);
  static const Color surfaceBlack3 = Color(0x1010107F);

  // Border Gradient
  static const LinearGradient borderGradient = LinearGradient(
    begin: Alignment(0.8, -0.6),
    end: Alignment(-1, 1),
    colors: [
      border3,
      border1,
      // border2,
    ],
  );
  static const Color border1 = Color(0xCCFFFFFF);
  static const Color border2 = Color(0xFFD9D9D9);
  static const Color border3 = Color(0x3DFFFFFF);

  //button gradient
  static const RadialGradient buttonGradient = RadialGradient(
    focalRadius: 3,
    radius: 3,
    colors: [Color(0xFF999999), Color(0x22222222)],
  );

  static const RadialGradient cardBG = RadialGradient(
    center: Alignment(-0.8, -0.84), // Corresponds to 'at 0% 8.04%'
    radius: 2, // Approximates the large elliptical shape
    colors: [
      Color.fromRGBO(34, 34, 34, 0.2),
      Color.fromRGBO(153, 153, 153, 0.2),
      Color.fromRGBO(34, 34, 34, 0.2),
    ],
    stops: [0.0, 0.4987, 1.0],
  );

   static RadialGradient recordingButtonGradient(Alignment center) =>
      RadialGradient(
        colors: const [
          Color.fromRGBO(34, 34, 34, 0.4),
          Color.fromRGBO(153, 153, 153, 0.4),
          Color.fromRGBO(34, 34, 34, 0.4),
        ],
        radius: 1.5,
        center: center,
      );
}
