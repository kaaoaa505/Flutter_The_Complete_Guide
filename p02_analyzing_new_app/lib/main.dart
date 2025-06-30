import 'package:flutter/material.dart';

import 'layout/gradient_container.dart';

void main() {
  // final colors = null;
  final colors = [
    const Color.fromARGB(255, 40, 63, 0),
    const Color.fromARGB(255, 0, 255, 225),
  ];
  runApp(
    MaterialApp(
      title: 'just for test',
      home: Scaffold(
        body: GradientContainer(colors: colors),
      ),
    ),
  );
}
