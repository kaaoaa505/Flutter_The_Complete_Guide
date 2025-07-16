import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p03_quiz_app/data/questions_object.dart';
import 'package:p03_quiz_app/ui/buttons/answer_btn.dart';

// ignore: must_be_immutable
class Questions extends StatefulWidget {
  final void Function(String) changeScreen;
  final void Function(String) addAnswer;

  const Questions({
    super.key,
    required this.changeScreen,
    required this.addAnswer,
  });

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  var currentQuestionIndex = 0;

  void saveAnswer(String answer) {
    widget.addAnswer(answer);

    if (currentQuestionIndex == 6) {
      currentQuestionIndex = 0;
    }

    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (currentQuestionIndex == 6) {
      currentQuestionIndex = 0;
    }
    
    final currentQuestion = questions[currentQuestionIndex];

    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                widget.changeScreen('start');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(50, 255, 255, 255),
              ),
              label: const Text('Back Home.'),
              icon: const Icon(Icons.arrow_back),
            ),
            const SizedBox(height: 30),
            Text(
              currentQuestion.text,
              style: GoogleFonts.amiri(
                color: const Color.fromARGB(255, 174, 147, 243),
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 30),
            ...currentQuestion.shuffledAnswers.map((answer) {
              return AnswerBtn(
                txt: answer,
                fun: () {
                  saveAnswer(answer);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
