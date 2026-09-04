import 'package:flutter/material.dart';
import 'package:photo_viewer/photo_viewer.dart';

class FramedImage extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  final double borderWidth;

  const FramedImage({
    super.key,
    required this.imageUrl,
    this.borderRadius = 22,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.primaryContainer,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: PhotoViewerImage(imageUrl: imageUrl),
        ),
      ),
    );
  }
}
