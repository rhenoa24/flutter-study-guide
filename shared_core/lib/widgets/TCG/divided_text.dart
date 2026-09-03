import 'package:flutter/material.dart';

class DividedText extends StatelessWidget {
  final String? text;
  final Widget? child;
  const DividedText({super.key, this.text, this.child})
    : assert(
        text != null || child != null,
        'DividedText needs either text or child.',
      );

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
        child: child ?? Text(text!),
      ),
    );
  }
}
