import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData light = ThemeData(
    primaryColor: const Color(0xFF34C5D9), // Warna utama
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFFFFFFF), // Warna utama
      secondary: Color(0xFFF6F6F6), // Latar belakang
      surface: Color(0xFF0F0F0),// Elemen permukaan (card, FAB, dll.)
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFAEC), // Latar belakang scaffold
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black), // Teks utama
      bodyMedium: TextStyle(color: Colors.black87),  // Teks sekunder
    ),
  );

  static final ThemeData dark = ThemeData(
    primaryColor: const Color(0xFF1E88E5), // Warna utama (dark mode)
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFFFFFF), // Warna utama
      secondary: Color(0xFFFFFFFF), // Latar belakang
      surface: Color(0xFF000000),
      // Elemen permukaan
    ),
    scaffoldBackgroundColor: const Color(0xFF303030),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
  );
}