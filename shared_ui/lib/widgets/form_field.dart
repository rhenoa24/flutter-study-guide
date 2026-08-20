import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final ValueChanged<String> onChanged;
  final bool enabled;
  final TextEditingController? controller;

  const FormTextField({
    super.key,
    required this.label,
    required this.onChanged,
    this.enabled = true,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: enabled
            ? colorScheme.surfaceContainerLow
            : colorScheme.surface,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.surfaceContainerHighest),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.surfaceContainerHighest),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.primaryContainer),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.surfaceContainerLow),
        ),
      ),
    );
  }
}
