import 'package:flutter/material.dart';

class MealItemMetadataUi extends StatelessWidget {
  const MealItemMetadataUi({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white),
        SizedBox(width: 2),
        Text(label),
      ],
    );
  }
}
