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
import 'package:shared_ui/theme/app_theme.dart';
import 'package:shared_ui/widgets/app_bar.dart';
import 'package:shared_ui/widgets/section_title.dart';
import 'package:shared_ui/widgets/info_banner.dart';
import 'package:shared_ui/widgets/form_field.dart';
import 'package:shared_ui/widgets/form_checkbox.dart';
import 'package:shared_ui/widgets/form_dropdown.dart';
import 'package:shared_ui/widgets/form_button.dart';
import 'package:shared_ui/widgets/form_reminder.dart';

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

/// ---------------------------------------------------------------
/// DATA MODEL
/// ---------------------------------------------------------------

class PersonalDetails {
  String firstName;
  String middleName;
  bool noMiddleName;
  String lastName;
  String? suffix;
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
  final TextEditingController _middleNameController = TextEditingController();

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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Nav + Banner
            Padding(
              padding: EdgeInsets.all(10),
              child: TopAppBar(label: 'Details'),
            ),
            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoBanner(
                      text:
                          'Please complete the registration process.\n'
                          'All fields are required.',
                    ),
                    const SizedBox(height: 28),

                    SectionTitle(title: 'BASIC DETAILS'),
                    const SizedBox(height: 14),
                    FormTextField(
                      label: 'First Name',
                      onChanged: (value) {
                        setState(() => _details.firstName = value);
                      },
                    ),
                    const SizedBox(height: 14),
                    FormTextField(
                      label: 'Middle Name (optional)',
                      enabled: !_details.noMiddleName,
                      controller: _middleNameController,
                      onChanged: (value) {
                        setState(() => _details.middleName = value);
                      },
                    ),
                    const SizedBox(height: 14),
                    FormCheckbox(
                      title: const Text('I don\'t have a middle name.'),
                      value: _details.noMiddleName,
                      onChanged: (value) {
                        setState(() {
                          _details.noMiddleName = value ?? false;
                          if (_details.noMiddleName) {
                            _middleNameController.clear();
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 14),
                    FormTextField(
                      label: 'Last Name',
                      onChanged: (value) {
                        setState(() => _details.lastName = value);
                      },
                    ),
                    const SizedBox(height: 14),
                    FormTextField(
                      label: 'Suffix (Jr. Sr. III)',
                      onChanged: (value) {
                        setState(() => _details.suffix = value);
                      },
                    ),
                    const SizedBox(height: 28),
                    //
                    SectionTitle(title: 'ADDITIONAL INFORMATION'),
                    const SizedBox(height: 14),
                    FormDropdownField(
                      label: 'Gender',
                      value: _details.gender,
                      items: _genderOptions,
                      onChanged: (value) {
                        setState(() => _details.gender = value);
                      },
                    ),
                    const SizedBox(height: 14),
                    FormDropdownField(
                      label: 'Nationality',
                      value: _details.nationality,
                      items: _nationalityOptions,
                      onChanged: (value) {
                        setState(() => _details.nationality = value);
                      },
                    ),
                    const SizedBox(height: 28),
                    //
                    Text(
                      'By clicking Next, you confirm that the above information is true and complete.',
                      style: TextStyle(color: colorScheme.outline),
                    ),
                    const SizedBox(height: 14),
                    FormButton(
                      label: 'Next',
                      onPressed: _details.isComplete ? _onNext : null,
                    ),
                    const SizedBox(height: 8),

                    Visibility(
                      visible: !_details.isComplete,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: const FormReminder(
                        label: 'Please fill in all required fields.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _middleNameController.dispose();
    super.dispose();
  }
}
