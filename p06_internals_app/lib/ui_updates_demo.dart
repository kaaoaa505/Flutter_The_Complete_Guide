import 'package:flutter/material.dart';
import 'package:flutter_internals/ui_demo_buttons.dart';

class UIUpdatesDemo extends StatefulWidget {
  const UIUpdatesDemo({super.key});

  @override
  StatefulElement createElement() {
    print('UIUpdatesDemo createElement() called');
    return super.createElement();
  }

  @override
  State<UIUpdatesDemo> createState() {
    print('UIUpdatesDemo createState() called');
    return _UIUpdatesDemo();
  }
}

class _UIUpdatesDemo extends State<UIUpdatesDemo> {

  @override
  Widget build(BuildContext context) {
    print('UIUpdatesDemo build(BuildContext context) called');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Every Flutter developer should have a basic understanding of Flutter\'s internals!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Do you understand how Flutter updates UIs?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            UiDemoButtons(),
          ],
        ),
      ),
    );
  }
}
