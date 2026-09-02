// Landing Screen
import 'package:activity_5/screens/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_core/shared_core.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
                const Icon(Icons.admin_panel_settings, size: 96),
                const SizedBox(height: 24),
                const Text(
                  'Welcome, Admin',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap Start to register a new customer',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: colorScheme.outline),
                ),
                const SizedBox(height: 32),
                FormButton(
                  label: 'Start',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FormScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
