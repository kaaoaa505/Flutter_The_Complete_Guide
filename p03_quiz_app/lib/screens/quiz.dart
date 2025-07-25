import 'package:flutter/material.dart';
import 'package:p03_quiz_app/data/questions_object.dart';
import 'package:p03_quiz_app/screens/quiz/questions.dart';
import 'package:p03_quiz_app/screens/quiz/result.dart';

import 'start.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;
  List<String> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    activeScreen = Start(changeScreen);
    selectedAnswers = [];
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

    if (selectedAnswers.length == 7) {
      selectedAnswers = [];
    }

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = Result(
          changeScreen: changeScreen,
          answers: [...selectedAnswers],
        );
        // selectedAnswers = [];
      });
    }
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
