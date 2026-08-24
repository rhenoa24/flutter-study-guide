import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const TopAppBar({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: colorScheme.primaryContainer,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
