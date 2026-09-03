import 'package:flutter/material.dart';

class ThumbnailListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? trailingText;
  final String? imageUrl;
  final VoidCallback onTap;
  final double imageWidth;
  final double imageHeight;

  const ThumbnailListTile({
    super.key,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.trailingText,
    this.imageUrl,
    this.imageWidth = 59,
    this.imageHeight = 64,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      leading: SizedBox(
        width: imageWidth,
        height: imageHeight,
        child: imageUrl == null
            ? const Icon(Icons.image_not_supported)
            : ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, StackTrace) =>
                      const Icon(Icons.broken_image),
                ),
              ),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: subtitle == null
          ? null
          : Text(subtitle!, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: trailingText == null
          ? null
          : Text(
              trailingText!,
              style: TextStyle(color: colorScheme.primaryContainer),
            ),
    );
  }
}
