import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Define color constants
const Color primaryColor = Color(0xFF4CAF50);
const Color secondaryColor = Color(0xFFFFFFFF);
const Color tertiaryColor = Color(0xFF9E9E9E);
const Color accentColor = Color(0xFFFF9800);

// Define standard font sizes for different devices
const double mobileFontSizeScale = 1.0;
const double tabletFontSizeScale = 1.2;
const double desktopFontSizeScale = 1.5;

// Function to get responsive font size based on device type
double getResponsiveFontSize(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;
  if (width > 1200) {
    return desktopFontSizeScale;
  } else if (width > 600) {
    return tabletFontSizeScale;
  } else {
    return mobileFontSizeScale;
  }
}

// Define the light theme
ThemeData lightTheme(BuildContext context) {
  final double fontSizeScale = getResponsiveFontSize(context);

  return ThemeData(
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
      displayLarge: GoogleFonts.poppins(
        fontSize: 96.0 * fontSizeScale,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 60.0 * fontSizeScale,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 48.0 * fontSizeScale,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 34.0 * fontSizeScale,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24.0 * fontSizeScale,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 20.0 * fontSizeScale,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16.0 * fontSizeScale,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14.0 * fontSizeScale,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16.0 * fontSizeScale,
        color: tertiaryColor,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14.0 * fontSizeScale,
        color: Colors.black,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12.0 * fontSizeScale,
        color: Colors.green,
      ),
    ),

    // Bottom navigation bar theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: secondaryColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: tertiaryColor,
      elevation: 0,
    ),

    // AppBar theme
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20.0 * fontSizeScale,
        fontWeight: FontWeight.bold,
        color: secondaryColor,
      ),
      iconTheme: const IconThemeData(
        color: secondaryColor,
      ),
    ),

    // Outlined button theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: secondaryColor,
        iconColor: primaryColor,
        foregroundColor: primaryColor,
        textStyle: GoogleFonts.poppins(
          fontSize: 16.0 * fontSizeScale,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
        surfaceTintColor: secondaryColor,
        textStyle: GoogleFonts.poppins(
          fontSize: 16.0 * fontSizeScale,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}