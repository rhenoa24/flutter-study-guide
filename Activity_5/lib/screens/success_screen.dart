import 'package:activity_5/constants/storage_keys.dart';
import 'package:activity_5/models/registrant_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});
  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final _prefsHelper = SharedPrefsHelper();
  PersonalDetails? _details;

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    final storedJson = await _prefsHelper.readSharedPreference(
      StorageKeys.personalDetails,
    );
    if (storedJson != null) {
      setState(() => _details = PersonalDetails.decode(storedJson));
    }
  }

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
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      const SizedBox(height: 8),
                      if (_details != null)
                        Text(
                          _details.toString(),
                          style: TextStyle(
                            fontSize: 8,
                            color: colorScheme.inversePrimary,
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
