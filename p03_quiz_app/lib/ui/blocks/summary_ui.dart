import 'dart:convert';

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
            Text(
              ((item['index'] as int) + 1).toString(),
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    item['question'] as String,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    item['correct_answer'] as String,
                    style: TextStyle(color: Colors.lightBlueAccent, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    item['user_answer'] as String,
                    style: TextStyle(color: Colors.lightBlueAccent, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Is Correct: ${item['is_correct'] as String}',
                    style: TextStyle(color: Colors.lightBlueAccent, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
