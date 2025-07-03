import 'package:flutter/material.dart';

import 'center_middle_text.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  var activeDice = 1;

  void rollTheDice() {
    setState(() {
      activeDice++;
      activeDice = activeDice == 0 || activeDice == 7
          ? 1
          : activeDice = activeDice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice-$activeDice.png',
          width: 200,
          height: 200,
        ),
        Center(
          child: CenterMiddleText(
            text:
                'Khaled Allam \n'
                '${DateTime.now().toString().split('.').first}\n'
                'خالد علام',
          ),
        ),
        SizedBox(height: 20),
        TextButton(
          onPressed: rollTheDice,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(20),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Text('Roll the dice'),
        ),
      ],
    );
  }
}
