import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen();

  void _backToHome(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

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
                      Icon(
                        Icons.check_circle,
                        size: 96,
                        color: colorScheme.primaryContainer,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Registration Successful',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your details have been submitted. You will receive a confirmation email shortly.',
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
                  label: 'Back to Home',
                  onPressed: () => _backToHome(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
