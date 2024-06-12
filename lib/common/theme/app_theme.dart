import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meeteri/common/theme/pallets.dart';



class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      textTheme: GoogleFonts.latoTextTheme(
          const TextTheme()),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      textTheme: GoogleFonts.latoTextTheme(const TextTheme()),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColors.primary,
      ),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
