import 'package:flutter/material.dart';

class UiDemoButtons extends StatefulWidget {
  const UiDemoButtons({super.key});

  @override
  State<UiDemoButtons> createState() {
    print('UiDemoButtons createState() called');
    return _UiDemoButtonsState();
  }
}

class _UiDemoButtonsState extends State<UiDemoButtons> {

  var _isUnderstood = false;
  @override
  Widget build(BuildContext context) {
    print('UiDemoButtons build(BuildContext context) called');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isUnderstood = false;
                });
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isUnderstood = true;
                });
              },
              child: const Text('Yes'),
            ),
          ],
        ),
        if (_isUnderstood) const Text('Awesome!'),
      ],
    );
  }
}
