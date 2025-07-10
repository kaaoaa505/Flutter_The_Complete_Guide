import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Questions extends StatefulWidget {
  final void Function(String) changeScreen;
  final String targetScreen;

  const Questions(this.changeScreen, this.targetScreen, {super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Questions Screen: ${widget.targetScreen}',
            style: const TextStyle(color: Colors.greenAccent),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {
              widget.changeScreen('start');
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(50, 255, 255, 255),
            ),
            label: const Text('Back'),
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
