import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnswerBtn extends StatelessWidget {
  AnswerBtn({super.key, required this.txt, required this.fun});

  String txt;
  void Function() fun;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: fun,
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 137, 198, 231),
        backgroundColor: const Color.fromARGB(255, 15, 39, 81),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      ),
      child: Text(txt, textAlign: TextAlign.center),
    );
  }
}
