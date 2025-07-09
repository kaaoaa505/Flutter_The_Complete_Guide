import 'package:flutter/material.dart';

import 'start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Color> colors = [
    const Color.fromARGB(255, 60, 39, 95),
    const Color.fromARGB(255, 27, 60, 65),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
