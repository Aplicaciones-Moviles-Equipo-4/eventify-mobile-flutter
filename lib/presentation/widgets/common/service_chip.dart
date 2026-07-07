import 'package:flutter/material.dart';

// Reusable widget to display a label/service as a Chip.
// Automatically adapts its background and text colors using the current theme's color scheme (surfaceVariant).
class ServiceChip extends StatelessWidget {
  final String label;

  const ServiceChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontSize: 12,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
    );
  }
}
