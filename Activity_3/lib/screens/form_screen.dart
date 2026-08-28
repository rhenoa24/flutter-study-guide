import 'package:activity_3/models/personal_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_ui/widgets/app_bar.dart';
import 'package:shared_ui/widgets/form_button.dart';
import 'package:shared_ui/widgets/form_checkbox.dart';
import 'package:shared_ui/widgets/form_dropdown.dart';
import 'package:shared_ui/widgets/form_field.dart';
import 'package:shared_ui/widgets/form_reminder.dart';
import 'package:shared_ui/widgets/info_banner.dart';
import 'package:shared_ui/widgets/section_title.dart';

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
