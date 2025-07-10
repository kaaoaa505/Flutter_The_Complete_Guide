import 'package:flutter/material.dart';

class AnswerBtn extends StatelessWidget {
  AnswerBtn(this.txt, {super.key});
  String txt;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text(txt));
  }
}
