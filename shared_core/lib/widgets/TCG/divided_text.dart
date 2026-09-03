import 'package:flutter/material.dart';

class DividedText extends StatelessWidget {
  final String text;
  const DividedText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colorScheme.primaryContainer, width: 1),
          bottom: BorderSide(color: colorScheme.primaryContainer, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(text),
      ),
    );
  }
}
