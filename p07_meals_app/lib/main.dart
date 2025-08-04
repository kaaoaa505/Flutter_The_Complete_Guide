import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p07_meals_app/app/screens/categories_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Define color scheme first
    final colorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromRGBO(39, 78, 90, 1.0),
    );

    // Create theme with properly configured text styles
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.latoTextTheme().copyWith(
        bodyLarge: GoogleFonts.lato(color: Colors.white),
        bodyMedium: GoogleFonts.lato(color: Colors.white),
        headlineMedium: GoogleFonts.lato(color: Colors.white),
        titleLarge: GoogleFonts.lato(color: colorScheme.primary, fontWeight: FontWeight.bold),
      ),
    );

    return MaterialApp(
      theme: theme,
      home: const CategoriesScreen(),
    );
  }
}