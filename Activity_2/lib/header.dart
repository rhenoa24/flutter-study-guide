// Top Row Header: Avatar + Greeting + Mail Icons
import 'package:flutter/material.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(Icons.person, color: colorScheme.onSurface, size: 28),
        ),
        const SizedBox(width: 12),
        Text(
          'Good Evening!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Icon(Icons.mail_outline, size: 26, color: colorScheme.primaryContainer),
      ],
    );
  }
}
