import 'dart:ffi';

import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Start Screen',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          Image.asset('assets/images/quiz.png', width: 100),
          SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.redAccent,
            ),
            label: Text('Start'),
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
