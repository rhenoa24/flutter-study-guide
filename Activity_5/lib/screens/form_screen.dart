// Copied this code from Activity_3

import 'package:activity_5/bloc/registration_bloc.dart';
import 'package:activity_5/bloc/registration_event.dart';
import 'package:activity_5/bloc/registration_state.dart';
import 'package:activity_5/models/registrant_details.dart';
import 'package:activity_5/screens/failed_screen.dart';
import 'package:activity_5/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_core/shared_core.dart';

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
  final _middleNameController = TextEditingController();

  @override
  void dispose() {
    _middleNameController.dispose();
    super.dispose();
  }

  void _updateField({
    String? firstName,
    String? middleName,
    bool? noMiddleName,
    String? lastName,
    String? suffix,
    String? gender,
    String? nationality,
  }) {
    setState(() {
      _details = _details.copyWith(
        firstName: firstName,
        middleName: middleName,
        noMiddleName: noMiddleName,
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
          Navigator.push(
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
                child: TopAppBar(
                  label: 'Details',
                  onPressed: () => Navigator.pop(context),
                ),
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
                        onChanged: (value) => _updateField(firstName: value),
                      ),
                      const SizedBox(height: 14),
                      FormTextField(
                        label: 'Middle Name (optional)',
                        enabled: !_details.noMiddleName,
                        controller: _middleNameController,
                        onChanged: (value) => _updateField(middleName: value),
                      ),
                      const SizedBox(height: 14),
                      FormCheckbox(
                        title: const Text('I don\'t have a middle name.'),
                        value: _details.noMiddleName,
                        onChanged: (checked) {
                          final isChecked = checked ?? false;
                          if (isChecked) {
                            _middleNameController.clear();
                          }
                          _updateField(
                            noMiddleName: isChecked,
                            middleName: isChecked ? '' : null,
                          );
                        },
                      ),
                      const SizedBox(height: 14),
                      FormTextField(
                        label: 'Last Name',
                        onChanged: (value) => _updateField(lastName: value),
                      ),
                      const SizedBox(height: 14),
                      FormTextField(
                        label: 'Suffix (Jr. Sr. III)',
                        onChanged: (value) => _updateField(suffix: value),
                      ),
                      const SizedBox(height: 28),
                      //
                      SectionTitle(title: 'ADDITIONAL INFORMATION'),
                      const SizedBox(height: 14),
                      FormDropdownField(
                        label: 'Gender',
                        value: _details.gender,
                        items: genderOptions,
                        onChanged: (value) => _updateField(gender: value),
                      ),
                      const SizedBox(height: 14),
                      FormDropdownField(
                        label: 'Nationality',
                        value: _details.nationality,
                        items: nationalityOptions,
                        onChanged: (value) => _updateField(nationality: value),
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
                        onPressed: _details.isComplete
                            ? () {
                                context.read<RegistrationBloc>().add(
                                  SubmitRegistrationEvent(_details),
                                );
                              }
                            : null,
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
      ),
    );
  }
}
