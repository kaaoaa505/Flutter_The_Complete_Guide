import 'package:flutter/material.dart';

class CenterMiddleText extends StatelessWidget {
  final String text;
  const CenterMiddleText({super.key, required this.text});
  
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
