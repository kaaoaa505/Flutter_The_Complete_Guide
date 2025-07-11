import 'package:flutter/material.dart';

class AnswerBtn extends StatelessWidget {
  AnswerBtn({super.key, required this.txt, required this.fun});
  
  String txt;
  void Function() fun;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: fun,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.lightGreenAccent,
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5)
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40)
      ),
      child: Text(txt),
    );
  }
}
