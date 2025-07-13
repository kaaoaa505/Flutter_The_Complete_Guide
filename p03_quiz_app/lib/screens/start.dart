import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Start extends StatelessWidget {
  const Start(this.changeScreen, {super.key});

  final void Function(String) changeScreen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Start Screen',
            style: TextStyle(
              color: Color.fromARGB(50, 255, 255, 255),
              fontSize: 24,
            ),
          ),
          Image.asset(
            'assets/images/quiz.png',
            width: 100,
            color: Color.fromARGB(50, 255, 255, 255),
          ),
          SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: () {
              changeScreen('questions');
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(50, 255, 255, 255),
            ),
            label: Text('Start'),
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
