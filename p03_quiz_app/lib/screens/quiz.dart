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
  final List<String> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    activeScreen = Start(changeScreen);
  }

  void changeScreen(String screenName) {
    setState(() {
      if (screenName == 'start') {
        activeScreen = Start(changeScreen);
      } else if (screenName == 'questions') {
        activeScreen = Questions(
          changeScreen: changeScreen,
          addAnswer: addAnswer,
        );
      }
    });
  }

  void addAnswer(String answer) {
    selectedAnswers.add(answer);
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
