import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
// import 'package:p07_meals_app/app/screens/categories_screen.dart';
import 'package:p07_meals_app/app/screens/meals_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromRGBO(
      39,
      78,
      90,
      1.0,
    ), // RGB with opacity (1.0 = opaque)
  ),
  textTheme: GoogleFonts.latoTextTheme().copyWith(
    bodyLarge: GoogleFonts.lato(color: Colors.white),
    bodyMedium: GoogleFonts.lato(color: Colors.white),
    headlineMedium: GoogleFonts.lato(color: Colors.white),
    // Add other text styles as needed
  ),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      // home: CategoriesScreen(),
      home: MealsScreen(title: 'Meals Page:', meals: []),
    );
  }
}
