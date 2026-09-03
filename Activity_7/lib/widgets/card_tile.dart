import 'package:activity_7/models/mtg_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_core/widgets/TCG/thumbnail_list.dart';

class CardListTile extends StatelessWidget {
  final MtgCard card;
  final VoidCallback onTap;

  const CardListTile({super.key, required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ThumbnailListTile(
      title: card.name,
      subtitle: card.typeLine,
      trailingText: card.manaCost,
      imageUrl: card.displayImageUris?.small,
      onTap: onTap,
    );
  }
}
