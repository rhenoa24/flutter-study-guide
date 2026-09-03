import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  final String text;
  const CenteredMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
