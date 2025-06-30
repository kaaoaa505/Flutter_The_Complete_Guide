import 'package:flutter/material.dart';
import 'package:p02_analyzing_new_app/styled/center_middle_text.dart';

// var startAlignment = Alignment.topLeft;
// Alignment? startAlignment;
// final startAlignment = Alignment.topLeft;
const startAlignment = Alignment.topLeft;

// var endAlignment = Alignment.bottomRight;
// final endAlignment = Alignment.bottomRight;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  final List<Color>? colors;
  const GradientContainer({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    // startAlignment = Alignment.topLeft;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ?? [Colors.blue, Colors.purple],
          // begin: startAlignment ?? Alignment.topLeft,
          begin: startAlignment,
          end: endAlignment,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/dice-4.png', fit: BoxFit.contain),
          Center(
            child: CenterMiddleText(   
              text: 'Khaled Allam \n'
              '${DateTime.now().toString().split('.').first}\n'
              'خالد علام',
            ),
          ),
        ],
      ),
    );
  }
}
