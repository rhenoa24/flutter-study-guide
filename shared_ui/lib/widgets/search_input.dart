import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String hintText;
  final ValueChanged<String> onSubmitted;

  const SearchInput({
    super.key,
    this.controller,
    this.textInputAction,
    required this.hintText,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: colorScheme.surfaceContainerHigh),
        prefixIcon: Icon(Icons.search),
        //
        filled: true,
        fillColor: colorScheme.surfaceContainerLow,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.surfaceContainerHighest),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.primaryContainer),
        ),
      ),
    );
  }
}
