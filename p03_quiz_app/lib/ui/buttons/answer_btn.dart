import 'package:flutter/material.dart';

class AnswerBtn extends StatelessWidget {
  AnswerBtn(this.txt, this.fun, {super.key});
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
