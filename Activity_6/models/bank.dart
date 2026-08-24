class Bank {
  final String bankName;
  final String branch;
  final String branchCode;

  const Bank({
    required this.bankName,
    required this.branch,
    required this.branchCode,
  });

  Bank copyWith({String? bankName, String? branch, String? branchCode}) {
    return Bank(
      bankName: bankName ?? this.bankName,
      branch: branch ?? this.branch,
      branchCode: branchCode ?? this.branchCode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bank &&
        other.bankName == bankName &&
        other.branch == branch &&
        other.branchCode == branchCode;
  }

  @override
  String toString() {
    return '''
Bank(
          bankName: $bankName
          branch: $branch
          branchCode: $branchCode)''';
  }
}
