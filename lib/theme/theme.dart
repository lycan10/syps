import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class ThemeClass {
  // Base colors
  static const Color blackColor = Color(0xff000000);
  static const Color textColor = Color(0xff121212);
  static const Color whiteColor = Color(0xffF6F6F6);
  static const Color greyColor = Color(0xff888888);
  static const Color greyColor2 = Color(0xffB0B0B0);
  static const Color greyColor3 = Color(0xffE7E7E7);

  // Category Colors 🌈
  static const Color dirtyColor = Color(0xffFF3B6A); // Hot Pink / Red
  static const Color icebreakerColor = Color(0xff009FFD); // Cool Blue
  static const Color ladiesNightColor = Color(0xffC77DFF); // Lavender / Magenta
  static const Color boysColor = Color(0xffFFB800); // Amber / Yellow
  static const Color loveAffairColor = Color(0xffFF4D4D); // Romantic Red

  // Accent Colors
  static const Color successColor = Color(0xff9EDF9C);
  static const Color infoColor = Color(0xff1A08AA);

  // Default Light Theme ☀️
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: whiteColor,
    primaryColor: dirtyColor,
    colorScheme: const ColorScheme.light(
      primary: dirtyColor,
      secondary: icebreakerColor,
      surface: whiteColor,
      onPrimary: whiteColor,
      onSecondary: blackColor,
      onSurface: textColor,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(
          color: blackColor,
          fontSize: 46,
          fontWeight: FontWeight.w300,
        ),
        headlineMedium: TextStyle(
          color: blackColor,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
        headlineSmall: TextStyle(
          color: blackColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          color: greyColor,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );

  // 🎨 Custom Color Themes for each Category

  static final Map<String, ThemeData> categoryThemes = {
    "dirty": lightTheme.copyWith(
      primaryColor: dirtyColor,
      scaffoldBackgroundColor: dirtyColor.withOpacity(0.05),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: dirtyColor,
        displayColor: dirtyColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: dirtyColor,
          foregroundColor: whiteColor,
        ),
      ),
    ),
    "icebreaker": lightTheme.copyWith(
      primaryColor: icebreakerColor,
      scaffoldBackgroundColor: icebreakerColor.withOpacity(0.05),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: icebreakerColor,
        displayColor: icebreakerColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: icebreakerColor,
          foregroundColor: whiteColor,
        ),
      ),
    ),
    "ladies": lightTheme.copyWith(
      primaryColor: ladiesNightColor,
      scaffoldBackgroundColor: ladiesNightColor.withOpacity(0.05),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: ladiesNightColor,
        displayColor: ladiesNightColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ladiesNightColor,
          foregroundColor: whiteColor,
        ),
      ),
    ),
    "boys": lightTheme.copyWith(
      primaryColor: boysColor,
      scaffoldBackgroundColor: boysColor.withOpacity(0.05),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: boysColor,
        displayColor: boysColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: boysColor,
          foregroundColor: whiteColor,
        ),
      ),
    ),
    "love": lightTheme.copyWith(
      primaryColor: loveAffairColor,
      scaffoldBackgroundColor: loveAffairColor.withOpacity(0.05),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: loveAffairColor,
        displayColor: loveAffairColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: loveAffairColor,
          foregroundColor: whiteColor,
        ),
      ),
    ),
  };
}
