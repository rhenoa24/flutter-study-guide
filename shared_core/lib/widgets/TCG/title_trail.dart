import 'package:flutter/material.dart';

class TitleTrail extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? trailingText;

  const TitleTrail({
    super.key,
    required this.title,
    this.subtitle,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (subtitle != null) Text(subtitle!),
          ],
        ),

        const Spacer(),

        if (trailingText != null)
          Text(
            trailingText!,
            style: TextStyle(color: colorScheme.primaryContainer),
          ),
      ],
    );
  }
}
