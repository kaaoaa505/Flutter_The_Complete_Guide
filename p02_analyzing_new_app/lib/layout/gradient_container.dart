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
  const GradientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // startAlignment = Alignment.topLeft;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 40, 63, 0),
            Color.fromARGB(255, 0, 255, 225),
          ],
          // begin: startAlignment ?? Alignment.topLeft,
          begin: startAlignment,
          end: endAlignment,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: CenterMiddleText(),
      ),
    );
  }
}
