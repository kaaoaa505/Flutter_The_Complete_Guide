import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Result extends StatelessWidget {
  const Result(this.changeScreen, {super.key});

  final void Function(String) changeScreen;

  @override
  Widget build(BuildContext context) {
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
          Text('TODO: Result screen...', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
