import 'package:flutter/material.dart';

class StatBar extends StatelessWidget {
  final String label;
  final num value;
  final num maxValue;
  final int labelWidth;
  final int valueWidth;

  const StatBar({
    super.key,
    required this.label,
    required this.value,
    this.maxValue = 255,
    this.labelWidth = 150,
    this.valueWidth = 30,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = (value / maxValue).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: labelWidth.toDouble(), child: Text(label)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(value: ratio, minHeight: 8),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: valueWidth.toDouble(),
            child: Text('$value', textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
