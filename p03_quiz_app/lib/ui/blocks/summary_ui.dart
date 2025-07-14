import 'package:flutter/material.dart';

class SummaryUi extends StatelessWidget {
  const SummaryUi({super.key, required this.data});

  final List<Map<String, Object>> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.map((item) {
        return Row(
          children: [
            Text(((item['index'] as int) + 1).toString()),
            Column(
              children: [
                Text(item['question'] as String), SizedBox(height: 5),
                Text(item['correct_answer'] as String), SizedBox(height: 5),
                Text(item['user_answer'] as String), SizedBox(height: 5),
                Text('Is Correct: ${item['is_correct'] as String}'), SizedBox(height: 5),
                ],
            ),
          ],
        );
      }).toList(),
    );
  }
}
