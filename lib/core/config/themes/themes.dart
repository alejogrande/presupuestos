import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    const primaryPurple = Color.fromARGB(
      255,
      121,
      67,
      245,
    ); // Morado principal (Violet 500)
    const backgroundColor = Color(0xFFF8F5FF); // Fondo muy claro

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryPurple,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: primaryPurple,
            brightness: Brightness.light,
          ).copyWith(
            surface: const Color.fromARGB(255, 248, 245, 255),
            onSurface: const Color.fromARGB(255, 33, 33, 33),
          ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 121, 67, 245),
        foregroundColor: Colors.black,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Color.fromARGB(222, 0, 0, 0),
        ), // ≈ black87
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Color.fromARGB(222, 0, 0, 0),
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryPurple),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
      ),
    );
  }
}
