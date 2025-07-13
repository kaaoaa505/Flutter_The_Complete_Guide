import 'package:flutter/material.dart';
import 'package:p03_quiz_app/data/questions_object.dart';
import 'package:p03_quiz_app/ui/buttons/answer_btn.dart';

// ignore: must_be_immutable
class Questions extends StatefulWidget {
  final void Function(String) changeScreen;

  const Questions(this.changeScreen, {super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[0];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            style: const TextStyle(color: Colors.greenAccent),
          ),
          const SizedBox(height: 30),
          ...currentQuestion.answers.map((answer) {
            return AnswerBtn(txt: answer, fun: () {});
          }),
        ],
      ),
    );
  }
}
