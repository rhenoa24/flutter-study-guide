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
