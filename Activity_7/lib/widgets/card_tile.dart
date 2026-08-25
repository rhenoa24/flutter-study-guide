import 'package:activity_7/models/mtg_card.dart';
import 'package:flutter/material.dart';

class CardListTile extends StatelessWidget {
  final MtgCard card;
  final VoidCallback onTap;

  const CardListTile({super.key, required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl = card.displayImageUris?.small;
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: onTap,
      leading: SizedBox(
        width: 48,
        height: 64,
        child: thumbnailUrl == null
            ? const Icon(Icons.image_not_supported)
            : ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  thumbnailUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, StackTrace) =>
                      const Icon(Icons.broken_image),
                ),
              ),
      ),
      title: Text(card.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        card.typeLine,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        card.manaCost ?? '',
        style: TextStyle(color: colorScheme.primaryContainer),
      ),
    );
  }
}
