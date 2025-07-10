import 'package:flutter/material.dart';

class AnswerBtn extends StatelessWidget {
  AnswerBtn({super.key, required this.txt, required this.fun});
  
  String txt;
  void Function() fun;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: fun,
      style: ElevatedButton.styleFrom(),
      child: Text(txt),
    );
  }
}
