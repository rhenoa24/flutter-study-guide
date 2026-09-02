import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool enabled;

  const FormButton({
    super.key,
    required this.label,
    this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: enabled ? onPressed : null,
        child: Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
