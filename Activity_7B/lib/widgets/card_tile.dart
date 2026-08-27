import 'package:flutter/material.dart';

class CardListTile extends StatelessWidget {
  final int id;
  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  const CardListTile({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.onTap,
  });

  String get _capitalizedName =>
      name.isEmpty ? name : name[0].toUpperCase() + name.substring(1);

  String get _formattedId => '#${id.toString().padLeft(3, '0')}';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      leading: SizedBox(
        width: 48,
        height: 48,
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          },
        ),
      ),
      title: Text(
        _capitalizedName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        _formattedId,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colorScheme.primaryContainer,
        ),
      ),
    );
  }
}
