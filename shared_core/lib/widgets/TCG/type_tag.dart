import 'package:flutter/material.dart';

class TypeTag extends StatelessWidget {
  final List<String> tags;
  final List<Color>? tagColors;
  final double spacing;

  const TypeTag({
    super.key,
    required this.tags,
    this.tagColors,
    this.spacing = 8,
  }) : assert(
         tagColors == null || tagColors.length == tags.length,
         'tagColors must be the same length as tags when provided.',
       );

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      children: List.generate(tags.length, (i) {
        final color = tagColors?[i];

        return Chip(
          label: Text(
            tags[i],
            style: color != null
                ? TextStyle(color: _textColorFor(color))
                : null,
          ),
          backgroundColor: color,
        );
      }),
    );
  }

  static Color _textColorFor(Color background) {
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
