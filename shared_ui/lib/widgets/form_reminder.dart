import 'package:flutter/material.dart';

class FormReminder extends StatelessWidget {
  final String label;

  const FormReminder({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        label,
        style: TextStyle(color: colorScheme.outline, fontSize: 13),
      ),
    );
  }
}
