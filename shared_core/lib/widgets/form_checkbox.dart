import 'package:flutter/material.dart';

class FormCheckbox extends StatelessWidget {
  final Widget? title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const FormCheckbox({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: title,
      controlAffinity: ListTileControlAffinity.leading,
      value: value,
      onChanged: onChanged,
    );
  }
}
