import 'package:activity_7/models/mtg_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_ui/widgets/app_bar.dart';

class CardDetailScreen extends StatelessWidget {
  final MtgCard card;
  const CardDetailScreen({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final imageUrl = card.displayImageUris?.normal;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Nav
            Padding(
              padding: EdgeInsets.all(10),
              child: TopAppBar(
                label: card.name,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    if (imageUrl != null)
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(imageUrl),
                        ),
                      ),
                    const SizedBox(height: 16),

                    // Card Name
                    Text(card.name),

                    // Mana Cost
                    if (card.manaCost != null) ...[
                      const SizedBox(height: 4),
                      Text(card.manaCost!),
                    ],
                    const SizedBox(height: 8),

                    // Type Line
                    Text(
                      card.typeLine,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 12),

                    // Oracle Text
                    if (card.oracleText != null) Text(card.oracleText!),

                    // Card Power
                    if (card.power != null && card.toughness != null)
                      Text('Power/Toughness: ${card.power}/${card.toughness}'),
                    const SizedBox(height: 8),

                    // Set
                    Text('Set: ${card.setName}'),

                    // Rarity
                    Text('Rarity: ${card.rarity}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
