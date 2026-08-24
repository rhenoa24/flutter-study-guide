import 'package:flutter/material.dart';
import 'package:shared_ui/widgets/form_button.dart';

class FailedScreen extends StatelessWidget {
  const FailedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 96, color: colorScheme.error),
                      const SizedBox(height: 24),
                      Text(
                        'Registration Failed',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Something went wrong while saving. Please try again.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
                FormButton(
                  // "Try again" goes back to the form to re-submit.
                  label: 'Try Again',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
