// ## 🎯 Activity 3

// Create a basic form.

// - Create datamodel for the details
// - Use Textformfield for the text fields
// - Use dropdown fields for Gender and Nationality
// - Update the datamodel value with the form data using onchange listener and setState
// - Next button only enables if all fields are complete. Utilize StatefulWidget and datamodel for logic.
// - Ignore the back button functionality
// - Ignore the checkbox

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
      home: const FormScreen(),
    );
  }
}

/// ---------------------------------------------------------------
/// DATA MODEL
/// ---------------------------------------------------------------

class PersonalDetails {
  String firstName;
  String middleName;
  bool noMiddleName;
  String lastName;
  String suffix;
  String? gender;
  String? nationality;

  PersonalDetails({
    this.firstName = '',
    this.middleName = '',
    this.noMiddleName = false,
    this.lastName = '',
    this.suffix = '',
    this.gender,
    this.nationality,
  });

  // BLoC (for form validation)
  bool get isComplete {
    final middleOk = noMiddleName || middleName.trim().isNotEmpty;
    return firstName.trim().isNotEmpty &&
        middleOk && // Middle name can be empty or filled
        lastName.trim().isNotEmpty &&
        gender != null &&
        nationality != null;
    // I didn't count the suffix as required, despite the clear infocard in the mockup
    // because not everyone has suffixes. This would be terrible UX
  }

  @override
  String toString() {
    return 'PersonalDetails(firstName: $firstName, middleName: $middleName, noMiddleName: $noMiddleName, lastName: $lastName, suffix: $suffix, gender: $gender, nationality: $nationality)';
  }
}

// ============================================================
// FORM SCREEN
// ============================================================

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final PersonalDetails _details = PersonalDetails();

  // Values for the dropdown fields
  static const List<String> _genderOptions = ['Male', 'Female', 'Other'];
  static const List<String> _nationalityOptions = [
    'Filipino',
    'American',
    'Japanese',
    'Spanish',
    'etc.',
  ];

  // Just for debug!
  void _onNext() {
    debugPrint(_details.toString());
    const SnackBar(
      content: Text('Next button pressed! Details has been logged.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme = Theme.of(context).colorScheme;

    return Scaffold(backgroundColor: ColorScheme.surface);
  }
}
