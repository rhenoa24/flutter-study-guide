// White Pill buttons
import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const PillButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: colorScheme.onSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: colorScheme.surface),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
