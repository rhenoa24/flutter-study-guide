import 'package:flutter/material.dart';

class FormIconButton extends StatelessWidget {
  final Icon icon;
  final bool enabled;
  final VoidCallback? onPressed;

  const FormIconButton({
    super.key,
    required this.icon,
    this.enabled = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: enabled ? onPressed : null, icon: icon);
  }
}
