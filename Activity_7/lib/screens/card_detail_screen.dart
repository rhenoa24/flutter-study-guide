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
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorScheme.primaryContainer,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Image.network(imageUrl),
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        // Card Name
                        Text(
                          card.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        // Mana Cost
                        if (card.manaCost != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            card.manaCost!,
                            style: TextStyle(
                              color: colorScheme.primaryContainer,
                            ),
                          ),
                        ],
                      ],
                    ),

                    // Type Line
                    Text(card.typeLine, style: TextStyle()),
                    const SizedBox(height: 12),

                    if (card.oracleText != null)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: colorScheme.primaryContainer,
                              width: 1,
                            ),
                            bottom: BorderSide(
                              color: colorScheme.primaryContainer,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(card.oracleText!),
                        ),
                      ),

                    const SizedBox(height: 12),

                    // Card Power
                    if (card.power != null && card.toughness != null)
                      Text('Power/Toughness: ${card.power}/${card.toughness}'),

                    // Set
                    Text(
                      'Set: ${card.setName}',
                      style: TextStyle(color: colorScheme.outline),
                    ),

                    // Rarity
                    Text(
                      'Rarity: ${card.rarity}',
                      style: TextStyle(color: colorScheme.outline),
                    ),

                    const SizedBox(height: 12),
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
