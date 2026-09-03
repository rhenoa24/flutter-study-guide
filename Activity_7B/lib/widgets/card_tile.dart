import 'package:flutter/material.dart';
import 'package:shared_core/widgets/TCG/thumbnail_list.dart';

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
    return ThumbnailListTile(
      title: _capitalizedName,
      trailingText: _formattedId,
      imageUrl: imageUrl,
      onTap: onTap,
      imageWidth: 48,
      imageHeight: 48,
    );
  }
}
