import 'package:flutter/material.dart';

class CenterMiddleText extends StatelessWidget {
  const CenterMiddleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      ('Khaled Allam \n'
          'خالد علام'),
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
