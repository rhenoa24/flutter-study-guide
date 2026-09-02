// Action Buttons - Services

import 'package:flutter/material.dart';
import 'package:shared_core/widgets/action_tile.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key});

  static const List<Map<String, dynamic>> _items = [
    {'icon': Icons.smartphone, 'label': 'Buy Load'},
    {'icon': Icons.account_balance, 'label': 'Loans'},
    {'icon': Icons.credit_card, 'label': 'Cards'},
    {'icon': Icons.savings, 'label': 'PalaSave'},
    {'icon': Icons.shield, 'label': 'ProtektODO'},
    {'icon': Icons.paid, 'label': 'Claim Remittance'},
    {'icon': Icons.public, 'label': 'Pera Padala Abroad'},
    {'icon': Icons.diamond, 'label': 'Buy Jewelry'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = _items[index];
        return ActionTile(icon: item['icon'], label: item['label']);
      },
    );
  }
}
