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
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.redAccent,
            ),
            child: Text('Start'),
          ),
        ],
      ),
    );
  }
}
