// Action Buttons - Quick Actions
import 'package:flutter/material.dart';
import 'package:shared_core/widgets/action_tile.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: ActionTile(icon: Icons.description, label: 'Pay Bills'),
        ),
        SizedBox(width: 12),
        Expanded(
          child: ActionTile(icon: Icons.person, label: 'Send Money'),
        ),
        SizedBox(width: 12),
        Expanded(
          child: ActionTile(
            icon: Icons.account_balance,
            label: 'Bank Transfer',
          ),
        ),
      ],
    );
  }
}
