// ## 🎯 Activity 3

// Create a basic form.

// - Create datamodel for the details
// - Use Textformfield for the text fields
// - Use dropdown fields for Gender and Nationality
// - Update the datamodel value with the form data using onchange listener and setState
// - Next button only enables if all fields are complete. Utilize StatefulWidget and datamodel for logic.
// - Ignore the back button functionality
// - Ignore the checkbox

import 'package:activity_3/screens/form_screen.dart';
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
      home: const FormScreen(),
    );
  }
}
