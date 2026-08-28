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

import 'package:activity_4/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_ui/theme/app_theme.dart';

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
