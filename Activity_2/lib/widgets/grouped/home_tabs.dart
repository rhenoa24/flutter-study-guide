// Tab Row
import 'package:activity_2/widgets/tabs.dart';
import 'package:flutter/material.dart';

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
