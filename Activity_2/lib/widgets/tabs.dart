// Single Tab Label
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;

  const TabItem({super.key, required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? colorScheme.onSurface : colorScheme.outline,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 2,
          width: 46,
          color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
        ),
      ],
    );
  }
}

// Tab Row
class TabRow extends StatelessWidget {
  const TabRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TabItem(label: 'Home', isSelected: true),
        const SizedBox(width: 24),
        TabItem(label: 'Cards'),
        const SizedBox(width: 24),
        TabItem(label: 'Savings'),
        const SizedBox(width: 24),
        TabItem(label: 'Loans'),
      ],
    );
  }
}
