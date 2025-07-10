import 'package:flutter/material.dart';
import 'package:p03_quiz_app/screens/quiz/questions.dart';

import 'start.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;
  String targetScreen = 'start';

  @override
  void initState() {
    super.initState();
    activeScreen = Start(changeScreen, targetScreen);
  }

  void changeScreen(String screenName) {
    setState(() {
      targetScreen = screenName;
      if (targetScreen == 'start') {
        activeScreen = Start(changeScreen, targetScreen);
      } else if (targetScreen == 'questions') {
        activeScreen = Questions(changeScreen, targetScreen);
      }
    });
  }

  final List<Color> colors = [
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
          child: activeScreen,
        ),
      ),
    );
  }
}
