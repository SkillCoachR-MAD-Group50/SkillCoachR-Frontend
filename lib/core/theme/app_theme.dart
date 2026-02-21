import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0052D4),
        primary: const Color(0xFF0052D4),
        secondary: const Color(0xFF4364F7),
        tertiary: const Color(0xFF6FB1FC),
      ),
      textTheme: GoogleFonts.outfitTextTheme(),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0F3A9D), // Deep vibrant blue top
      Color(0xFF0F70C7), // Mid bright blue
      Color(0xFF70CFE4), // Light cyan bottom
    ],
  );
  
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0052D4),
      Color(0xFF4364F7),
      Color(0xFF6FB1FC),
    ],
  );
}
