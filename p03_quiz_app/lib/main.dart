import 'package:flutter/material.dart';
import 'package:p03_quiz_app/start_screen.dart';

void main() {
  List<Color> colors = [
    const Color.fromARGB(255, 60, 39, 95),
    const Color.fromARGB(255, 27, 60, 65),
  ];

  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: StartScreen(),
        ),
      ),
    ),
  );
}
