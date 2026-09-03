import 'package:flutter/material.dart';

class TypeTag extends StatelessWidget {
  final List<String> tags;
  final double spacing;

  const TypeTag({super.key, required this.tags, this.spacing = 8});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      children: tags.map((tag) => Chip(label: Text(tag))).toList(),
    );
  }
}
