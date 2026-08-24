class Customer {
  final String customerId;
  final String firstName;
  final String middleName;
  final String lastName;

  const Customer({
    required this.customerId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
  });

  Customer copyWith({
    String? customerId,
    String? firstName,
    String? middleName,
    String? lastName,
  }) {
    return Customer(
      customerId: customerId ?? this.customerId,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Customer &&
        other.customerId == customerId &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName;
  }

  @override
  int get hashCode => Object.hash(customerId, firstName, middleName, lastName);

  @override
  String toString() {
    return '''
Customer(
          customerId: $customerId
          firstName: $firstName
          middleName: $middleName
          lastName: $lastName)''';
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: json['customerId'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
    };
  }
}
