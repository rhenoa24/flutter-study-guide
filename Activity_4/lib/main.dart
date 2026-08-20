// ## 🎯 Activity 4

// - Create a helper class for saving and retrieving SharePreference data
// - Should contain 2 functions, **saveSharedPreference** & **readSharedPreference**.
// - Test the two functions by storing a value and then retrieving them after.

// - Create a basic screen with a button and text. Text will have value from **readSharedPreferences**. Only display the text if theres a value.
// - When the button is pressed, call the **saveSharedPreference** function to save a default value.

// **Test:**
// - Initial run, text not visible and only button.
// - Presses the button.
// - Close and Rereun the application. Value must persist.
// - Uninstall and reinstall the application. Value should be empty again.

import 'package:flutter/material.dart';
import 'package:shared_ui/helpers/shared_prefs_helper.dart';
import 'package:shared_ui/theme/app_theme.dart';
import 'package:shared_ui/widgets/app_bar.dart';
import 'package:shared_ui/widgets/form_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 3',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const TestScreen(),
    );
  }
}

// ============================================================
// TESTING SCREEN
// ============================================================
class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String? _savedValue;

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  Future<void> _loadValue() async {
    final value = await SharedPrefsHelper.readSharedPreference();
    setState(() {
      _savedValue = value;
    });
  }

  Future<void> _onSavePressed() async {
    await SharedPrefsHelper.saveSharedPreference(
      'Hello! This value was saved via [SharedPreference].',
    );
    await _loadValue();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasValue = _savedValue != null && _savedValue!.isNotEmpty;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Nav + Banner
            Padding(
              padding: EdgeInsets.all(10),
              child: TopAppBar(label: 'Shared Preferences Test'),
            ),
            Expanded(
              child: Center(
                child: hasValue
                    ? Text(
                        _savedValue!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: FormButton(onPressed: _onSavePressed, label: 'Save Value'),
            ),
          ],
        ),
      ),
    );
  }
}
