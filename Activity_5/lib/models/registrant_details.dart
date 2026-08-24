import 'dart:convert';

// Reused the data model from Activity_3
// extended with fromJson/toJson so it can persist as a String
// via SharedPreferences (Activity_4)

/// ---------------------------------------------------------------
/// DATA MODEL
/// ---------------------------------------------------------------

class PersonalDetails {
  final String firstName;
  final String middleName;
  final bool noMiddleName;
  final String lastName;
  final String? suffix;
  final String? gender;
  final String? nationality;

  const PersonalDetails({
    required this.firstName,
    required this.middleName,
    this.noMiddleName = false,
    required this.lastName,
    this.suffix,
    this.gender,
    this.nationality,
  });

  // Initial State
  factory PersonalDetails.empty() {
    return const PersonalDetails(
      firstName: '',
      middleName: '',
      noMiddleName: false,
      lastName: '',
      suffix: '',
      gender: null,
      nationality: null,
    );
  }

  // BLoC (for form validation)
  bool get isComplete {
    return firstName.trim().isNotEmpty &&
        lastName.trim().isNotEmpty &&
        gender != null &&
        nationality != null &&
        (noMiddleName || middleName.trim().isNotEmpty);
    // I didn't count the suffix as required, despite the clear infocard in the mockup
    // because not everyone has suffixes. This would be terrible UX
  }

  /// ---------------------------------------------------------------
  // Learned from Activity_1

  PersonalDetails copyWith({
    String? firstName,
    String? middleName,
    bool? noMiddleName,
    String? lastName,
    String? suffix,
    String? gender,
    String? nationality,
  }) {
    return PersonalDetails(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      noMiddleName: noMiddleName ?? this.noMiddleName,
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
        other.noMiddleName == noMiddleName &&
        other.lastName == lastName &&
        other.suffix == suffix &&
        other.gender == gender &&
        other.nationality == nationality;
  }

  @override
  int get hashCode => Object.hash(
    firstName,
    middleName,
    noMiddleName,
    lastName,
    suffix,
    gender,
    nationality,
  );

  /// ---------------------------------------------------------------

  @override
  String toString() {
    return 'PersonalDetails(firstName: $firstName, middleName: $middleName, lastName: $lastName, suffix: $suffix, gender: $gender, nationality: $nationality)';
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'middleName': middleName,
      'noMiddleName': noMiddleName,
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
      noMiddleName: json['noMiddleName'] as bool? ?? false,
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
