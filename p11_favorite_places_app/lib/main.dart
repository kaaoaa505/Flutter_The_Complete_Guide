import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:p11_favorite_places_app/screens/places_list_screen.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  surface: const Color.fromARGB(255, 56, 49, 66),
);

final theme = ThemeData(
  useMaterial3: true, // ✅ recommended for modern Material widgets
).copyWith(
  scaffoldBackgroundColor: colorScheme.surface,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.normal,
      fontSize: 20.0,
      letterSpacing: 2.15,
      color: Colors.white, // ✅ cleaner than hardcoding ARGB white
    ),
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // ✅ ensure bindings before async work

  // Load .env file
  try {
    await dotenv.load(fileName: ".env");
    debugPrint('✅ .env file loaded successfully');
  } catch (e) {
    debugPrint('⚠️ Error loading .env file: $e');
    // Try with absolute path
    try {
      await dotenv.load(fileName: "${Directory.current.path}/.env");
      debugPrint('✅ .env file loaded with absolute path');
    } catch (e2) {
      debugPrint('⚠️ Error loading .env with absolute path: $e2');
      debugPrint(
          'ℹ️ Continuing without .env file - some features may not work');
      // Continue without .env file
    }
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ✅ optional: removes debug banner
      title: 'Great Places',
      theme: theme,
      home: const PlacesListScreen(),
    );
  }
}
