import 'package:flutter/material.dart';
import 'package:p02_analyzing_new_app/styled/dice_roller.dart';

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
      child: Center(child: DiceRoller()),
    );
  }
}
