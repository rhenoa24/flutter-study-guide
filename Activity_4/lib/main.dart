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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF007236),
          brightness: Brightness.dark,
          dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        ),
        fontFamily: 'Roboto',
      ),
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
  @override
  void initState() {
    super.initState();
  }
}
