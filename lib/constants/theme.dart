import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF4CAF50);
const Color secondaryColor = Color(0xFFFFFFFF);
const Color tertiaryColor = Color(0xFF9E9E9E);
const Color accentColor = Color(0xFFFF9800);
ThemeData lightTheme = ThemeData(
  // Color scheme
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: const MaterialColor(0xFF4CAF50, <int, Color>{
      50: Color(0xFFE8F5E9),
      100: Color(0xFFC8E6C9),
      200: Color(0xFFA5D6A7),
      300: Color(0xFF81C784),
      400: Color(0xFF66BB6A),
      500: Color(0xFF4CAF50),
      600: Color(0xFF43A047),
      700: Color(0xFF388E3C),
      800: Color(0xFF2E7D32),
      900: Color(0xFF1B5E20),
    }),
    accentColor: accentColor,
    errorColor: Colors.red,
  ),
  scaffoldBackgroundColor: secondaryColor,

  // Text theme
  textTheme: TextTheme(
    bodySmall: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Colors.green,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    bodyMedium: const TextStyle(color: Colors.black),
    bodyLarge: const TextStyle(color: tertiaryColor),
    headlineSmall: const TextStyle(color: primaryColor),
    headlineMedium: const TextStyle(color: primaryColor),
    headlineLarge: const TextStyle(color: primaryColor),
    titleLarge: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Colors.green,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    titleMedium: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
    titleSmall: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: secondaryColor,
    selectedItemColor: primaryColor,
    unselectedItemColor: tertiaryColor,
    elevation: 0,
  ),

  // AppBar theme
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: secondaryColor, // Sets the text color
    titleTextStyle: TextStyle(
      color: secondaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold, // Ensures the bold styling
    ),
    iconTheme: IconThemeData(
      color: secondaryColor, // Ensures icons are also visible
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    backgroundColor: secondaryColor,
    iconColor: primaryColor,
    foregroundColor: primaryColor,
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  )),

  // Button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor, // Sets the background color of the button
      foregroundColor: secondaryColor,
      surfaceTintColor: secondaryColor,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
);
