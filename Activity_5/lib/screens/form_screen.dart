// Copied this code from Activity_3

import 'package:activity_5/bloc/registration_bloc.dart';
import 'package:activity_5/bloc/registration_state.dart';
import 'package:activity_5/models/registrant_details.dart';
import 'package:activity_5/screens/failed_screen.dart';
import 'package:activity_5/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/theme/app_theme.dart';
import 'package:shared_ui/widgets/app_bar.dart';
import 'package:shared_ui/widgets/section_title.dart';
import 'package:shared_ui/widgets/info_banner.dart';
import 'package:shared_ui/widgets/form_field.dart';
import 'package:shared_ui/widgets/form_checkbox.dart';
import 'package:shared_ui/widgets/form_dropdown.dart';
import 'package:shared_ui/widgets/form_button.dart';
import 'package:shared_ui/widgets/form_reminder.dart';

// ============================================================
// FORM SCREEN
// ============================================================
// Values for the dropdown fields
const List<String> genderOptions = ['Male', 'Female', 'Other'];
const List<String> nationalityOptions = [
  'Filipino',
  'American',
  'Japanese',
  'Spanish',
  'etc.',
];

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationBloc(),
      child: const _FormView(),
    );
  }
}

class _FormView extends StatefulWidget {
  const _FormView();

  @override
  State<_FormView> createState() => _FormViewState();
}

class _FormViewState extends State<_FormView> {
  PersonalDetails _details = PersonalDetails.empty();

  void _updateField({
    String? firstName,
    String? middleName,
    String? lastName,
    String? suffix,
    String? gender,
    String? nationality,
  }) {
    setState(() {
      _details = _details.copyWith(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        suffix: suffix,
        gender: gender,
        nationality: nationality,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SuccessScreen()),
          );
        } else if (state is RegistrationFailure) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const FailedScreen()),
          );
        }
      },
      child: Scaffold(
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
              // Expanded(
              //   child: SingleChildScrollView(
              //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         InfoBanner(
              //           text:
              //               'Please complete the registration process.\n'
              //               'All fields are required.',
              //         ),
              //         const SizedBox(height: 28),

              //         SectionTitle(title: 'BASIC DETAILS'),
              //         const SizedBox(height: 14),
              //         FormTextField(
              //           label: 'First Name',
              //           onChanged: (value) {
              //             setState(() => _details.firstName = value);
              //           },
              //         ),
              //         const SizedBox(height: 14),
              //         FormTextField(
              //           label: 'Middle Name (optional)',
              //           enabled: !_details.noMiddleName,
              //           controller: _middleNameController,
              //           onChanged: (value) {
              //             setState(() => _details.middleName = value);
              //           },
              //         ),
              //         const SizedBox(height: 14),
              //         FormCheckbox(
              //           title: const Text('I don\'t have a middle name.'),
              //           value: _details.noMiddleName,
              //           onChanged: (value) {
              //             setState(() {
              //               _details.noMiddleName = value ?? false;
              //               if (_details.noMiddleName) {
              //                 _middleNameController.clear();
              //               }
              //             });
              //           },
              //         ),
              //         const SizedBox(height: 14),
              //         FormTextField(
              //           label: 'Last Name',
              //           onChanged: (value) {
              //             setState(() => _details.lastName = value);
              //           },
              //         ),
              //         const SizedBox(height: 14),
              //         FormTextField(
              //           label: 'Suffix (Jr. Sr. III)',
              //           onChanged: (value) {
              //             setState(() => _details.suffix = value);
              //           },
              //         ),
              //         const SizedBox(height: 28),
              //         //
              //         SectionTitle(title: 'ADDITIONAL INFORMATION'),
              //         const SizedBox(height: 14),
              //         FormDropdownField(
              //           label: 'Gender',
              //           value: _details.gender,
              //           items: _genderOptions,
              //           onChanged: (value) {
              //             setState(() => _details.gender = value);
              //           },
              //         ),
              //         const SizedBox(height: 14),
              //         FormDropdownField(
              //           label: 'Nationality',
              //           value: _details.nationality,
              //           items: _nationalityOptions,
              //           onChanged: (value) {
              //             setState(() => _details.nationality = value);
              //           },
              //         ),
              //         const SizedBox(height: 28),
              //         //
              //         Text(
              //           'By clicking Next, you confirm that the above information is true and complete.',
              //           style: TextStyle(color: colorScheme.outline),
              //         ),
              //         const SizedBox(height: 14),
              //         FormButton(
              //           label: 'Next',
              //           onPressed: _details.isComplete ? _onNext : null,
              //         ),
              //         const SizedBox(height: 8),

              //         Visibility(
              //           visible: !_details.isComplete,
              //           maintainSize: true,
              //           maintainAnimation: true,
              //           maintainState: true,
              //           child: const FormReminder(
              //             label: 'Please fill in all required fields.',
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
