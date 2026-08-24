import 'dart:convert';

import 'package:flutter/foundation.dart';

// Reused the data model from Activity_3
// extended with fromJson/toJson so it can persist as a String
// via SharedPreferences (Activity_4)

/// ---------------------------------------------------------------
/// DATA MODEL
/// ---------------------------------------------------------------

class PersonalDetails {
  final String firstName;
  final String middleName;
  final String lastName;
  final String suffix;
  final String gender;
  final String nationality;

  const PersonalDetails({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.suffix,
    required this.gender,
    required this.nationality,
  });

  // Initial State
  factory PersonalDetails.empty() {
    return const PersonalDetails(
      firstName: '',
      middleName: '',
      lastName: '',
      suffix: '',
      gender: '',
      nationality: '',
    );
  }

  // BLoC (for form validation)
  bool get isComplete {
    return firstName.trim().isNotEmpty &&
        lastName.trim().isNotEmpty &&
        gender.trim().isNotEmpty &&
        nationality.trim().isNotEmpty;
    // I didn't count the suffix as required, despite the clear infocard in the mockup
    // because not everyone has suffixes. This would be terrible UX
  }

  /// ---------------------------------------------------------------
  // Learned from Activity_1

  PersonalDetails copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? suffix,
    String? gender,
    String? nationality,
  }) {
    return PersonalDetails(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      suffix: suffix ?? this.suffix,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other))
      return true; //if the same object, skip field checks
    return other is PersonalDetails &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.suffix == suffix &&
        other.gender == gender &&
        other.nationality == nationality;
  }

  @override
  int get hashCode =>
      Object.hash(firstName, middleName, lastName, suffix, gender, nationality);

  /// ---------------------------------------------------------------

  @override
  String toString() {
    return 'PersonalDetails(firstName: $firstName, middleName: $middleName, lastName: $lastName, suffix: $suffix, gender: $gender, nationality: $nationality)';
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'suffix': suffix,
      'gender': gender,
      'nationality': nationality,
    };
  }

  factory PersonalDetails.fromJson(Map<String, dynamic> json) {
    return PersonalDetails(
      firstName: json['firstName'] as String? ?? '',
      middleName: json['middleName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      suffix: json['suffix'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      nationality: json['nationality'] as String? ?? '',
    );
  }

  // Encode straight to as JSON string from SharedPreferences
  String encode() => jsonEncode(toJson());

  // Decode straight from a JSON string
  static PersonalDetails decode(String source) =>
      PersonalDetails.fromJson(jsonDecode(source) as Map<String, dynamic>);
}
