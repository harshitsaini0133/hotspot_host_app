import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_assignment/core/app_color_pallete.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColorPallete.primaryColor,
    scaffoldBackgroundColor: AppColorPallete.base2,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColorPallete.primaryColor),
    useMaterial3: true,
    textTheme: GoogleFonts.spaceGroteskTextTheme(
      ThemeData.dark().textTheme,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        overlayColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        surfaceTintColor: Colors.white,
        shape: const CircleBorder(),
        highlightColor: Colors.transparent,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor:    Color(0x05FFFFFF),
      foregroundColor:   Color(0x05FFFFFF),
      surfaceTintColor:  Color(0x05FFFFFF),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      counterStyle: TextStyle(
        fontSize: 16,
        color: AppColorPallete.text5,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: AppColorPallete.surfaceWhite1,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 8.0,
      ),
      hintStyle: const TextStyle(
          color: AppColorPallete.text5,
          fontSize: 20,
          fontWeight: FontWeight.w400,),
      activeIndicatorBorder: BorderSide(
        color: AppColorPallete.primaryColor,
        width: 1.0,
        style: BorderStyle.solid,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: AppColorPallete.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
