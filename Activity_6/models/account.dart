class Account {
  final String accountNumber;
  final String accountName;
  final String accountType;
  final String currency;
  final double balance;
  final double availableBalance;
  final String status;
  final String openedDate;

  const Account({
    required this.accountNumber,
    required this.accountName,
    required this.accountType,
    required this.currency,
    required this.balance,
    required this.availableBalance,
    required this.status,
    required this.openedDate,
  });

  Account copyWith({
    String? accountNumber,
    String? accountName,
    String? accountType,
    String? currency,
    double? balance,
    double? availableBalance,
    String? status,
    String? openedDate,
  }) {
    return Account(
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      accountType: accountType ?? this.accountType,
      currency: currency ?? this.currency,
      balance: balance ?? this.balance,
      availableBalance: availableBalance ?? this.availableBalance,
      status: status ?? this.status,
      openedDate: openedDate ?? this.openedDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Account &&
        other.accountNumber == accountNumber &&
        other.accountName == accountName &&
        other.accountType == accountType &&
        other.currency == currency &&
        other.balance == balance &&
        other.availableBalance == availableBalance &&
        other.status == status &&
        other.openedDate == openedDate;
  }

  @override
  int get hashCode => Object.hash(
    accountNumber,
    accountNumber,
    accountType,
    currency,
    balance,
    availableBalance,
    status,
    openedDate,
  );

  @override
  String toString() {
    return 'Account('
        'accountNumber: $accountNumber'
        'accountName: $accountName'
        'accountType: $accountType'
        'currency: $currency'
        'balance: $balance'
        'availableBalance: $availableBalance'
        'status: $status'
        'openedDate: $openedDate'
        ')';
  }
}
