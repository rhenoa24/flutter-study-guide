import 'package:flutter/material.dart';

class MutedText extends StatelessWidget {
  final String text;
  const MutedText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(text, style: TextStyle(color: colorScheme.outline));
  }
}
