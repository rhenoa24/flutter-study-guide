// ## 🎯 Activity 3

// Create a basic form.

// - Create datamodel for the details
// - Use Textformfield for the text fields
// - Use dropdown fields for Gender and Nationality
// - Update the datamodel value with the form data using onchange listener and setState
// - Next button only enables if all fields are complete. Utilize StatefulWidget and datamodel for logic.
// - Ignore the back button functionality
// - Ignore the checkbox

import 'package:flutter/foundation.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Nav + Banner
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AppBar(label: 'Details'),
                  _InfoBanner(),
                ],
              ),
            ),
            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle(text: 'BASIC DETAILS'),
                    const SizedBox(height: 14),
                    _TextField(
                      label: 'First Name',
                      onChanged: (value) {
                        setState(() => _details.firstName = value);
                      },
                    ),
                    const SizedBox(height: 14),
                    _TextField(
                      label: 'Middle Name (optional)',
                      enabled: !_details.noMiddleName,
                      onChanged: (value) {
                        setState(() => _details.middleName = value);
                      },
                    ),
                    const SizedBox(height: 14),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('I don\'t have a middle name.'),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _details.noMiddleName,
                      onChanged: (value) {
                        setState(() {
                          _details.noMiddleName = value ?? false;
                          if (_details.noMiddleName) {
                            _details.middleName = '';
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 14),
                    _TextField(
                      label: 'Last Name',
                      onChanged: (value) {
                        setState(() => _details.lastName = value);
                      },
                    ),
                    const SizedBox(height: 14),
                    _TextField(
                      label: 'Suffix (Jr. Sr. III)',
                      onChanged: (value) {
                        setState(() => _details.suffix = value);
                      },
                    ),
                    const SizedBox(height: 28),
                    //
                    _SectionTitle(text: 'ADDITIONAL INFORMATION'),
                    const SizedBox(height: 14),
                    _DropdownField(
                      label: 'Gender',
                      items: _genderOptions,
                      onChanged: (value) {
                        setState(() => _details.gender = value);
                      },
                    ),
                    const SizedBox(height: 14),
                    _DropdownField(
                      label: 'Nationality',
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
                    _PillButton(
                      label: 'Next',
                      onPressed: _details.isComplete ? _onNext : null,
                    ),
                    const SizedBox(height: 8),
                    if (!_details.isComplete) _EmptyReminder(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// REUSABLE WIDGETS
// ============================================================

class _AppBar extends StatelessWidget {
  final String label;
  const _AppBar({required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back, size: 24)),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Please complete the registration process.\n'
              'All fields are required.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  final ValueChanged<String> onChanged;
  final bool enabled;

  const _TextField({
    required this.label,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      enabled: enabled,
      // onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: enabled
            ? colorScheme.surfaceContainerLow
            : colorScheme.surface,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.surfaceContainerHighest),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.surfaceContainerHighest),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.primaryContainer),
        ),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    required this.label,
    this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DropdownButtonFormField(
      initialValue: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: colorScheme.surfaceContainerLow,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.surfaceContainerHighest),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.surfaceContainerHighest),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.primaryContainer),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _PillButton({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onSurface,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          'Next',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _EmptyReminder extends StatelessWidget {
  const _EmptyReminder();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        'Please fill in all required fields.',
        style: TextStyle(color: colorScheme.outline, fontSize: 13),
      ),
    );
  }
}
