import 'package:flutter/material.dart';
import 'package:p03_quiz_app/data/questions_object.dart';
import 'package:p03_quiz_app/ui/blocks/summary_ui.dart';

// ignore: must_be_immutable
class Result extends StatelessWidget {
  Result({super.key, required this.changeScreen, required this.answers});

  final void Function(String) changeScreen;
  List<String> answers = [];

  List<Map<String, Object>> results() {
    List<Map<String, Object>> summary = [];

    for (var i = 0; i < answers.length; i++) {
      summary.add({
        'index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': answers[i],
        'is_correct': answers[i] == questions[i].answers[0] ? 'Yes' : 'No',
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final data = results();
    final numOfQuestions = questions.length;
    final numOfCorrectAnswers = data.where((item) {
      return item['is_correct'] as String == 'Yes';
    }).length;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              changeScreen('start');
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(50, 255, 255, 255),
            ),
            label: const Text('Back Home.'),
            icon: const Icon(Icons.arrow_back),
          ),
          Text(
            'You answered $numOfCorrectAnswers out of $numOfQuestions questions correctly!.',
            style: TextStyle(color: Colors.white),
          ),
          SummaryUi(data: data),
        ],
      ),
    );
  }
}
