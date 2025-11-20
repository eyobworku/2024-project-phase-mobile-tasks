import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 1. Define your specific colors here
  static const Color primaryBlue = Color(0xFF3F51F3);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFF3F3F3);
  static const Color textDark = Color(0xFF000000);
  static const Color textGrey = Color(0xFFAAAAAA);

  // 2. Create the Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundWhite,

      // Define the default font family for the whole app
      fontFamily: GoogleFonts.poppins().fontFamily,

      // Define default styles for common widgets
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: primaryBlue,
        surface: backgroundWhite,
      ),

      // Example: Standardize all ElevatedButtons (The Blue "ADD" / "UPDATE" buttons)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white, // Text color
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),

      // Example: Standardize TextFields (Input boxes)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: textGrey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
