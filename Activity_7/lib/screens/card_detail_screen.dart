import 'package:activity_7/models/mtg_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_core/shared_core.dart';

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
                label: 'Card Details',
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
                    if (imageUrl != null) FramedImage(imageUrl: imageUrl),

                    const SizedBox(height: 16),
                    TitleTrail(
                      title: card.name,
                      trailingText: card.manaCost,
                      subtitle: card.typeLine,
                    ),
                    const SizedBox(height: 12),

                    if (card.oracleText != null)
                      DividedText(text: card.oracleText!),
                    const SizedBox(height: 12),

                    // Card Power
                    if (card.power != null && card.toughness != null)
                      Text('Power/Toughness: ${card.power}/${card.toughness}'),

                    MutedText(text: card.setName),
                    MutedText(text: card.rarity),

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
