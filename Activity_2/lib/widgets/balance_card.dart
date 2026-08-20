// Balance Card
import 'package:flutter/material.dart';
import 'package:shared_ui/widgets/pill_button.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Balance',
            style: TextStyle(color: colorScheme.primary),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Php 10,000.00',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Icon(Icons.visibility_outlined, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text('1,200 Points'),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, size: 20),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: PillButton(icon: Icons.download, label: 'Cash In'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PillButton(icon: Icons.upload, label: 'Cash Out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
