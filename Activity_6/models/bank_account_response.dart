import 'account.dart';
import 'bank.dart';
import 'customer.dart';
import 'features.dart';

class BankAccountResponse {
  final Account account;
  final Bank bank;
  final Customer customer;
  final Features features;

  const BankAccountResponse({
    required this.account,
    required this.bank,
    required this.customer,
    required this.features,
  });

  BankAccountResponse copyWith({
    Account? account,
    Bank? bank,
    Customer? customer,
    Features? features,
  }) {
    return BankAccountResponse(
      account: account ?? this.account,
      bank: bank ?? this.bank,
      customer: customer ?? this.customer,
      features: features ?? this.features,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BankAccountResponse &&
        other.account == account &&
        other.bank == bank &&
        other.customer == customer &&
        other.features == features;
  }

  @override
  int get hashCode => Object.hash(account, bank, customer, features);

  @override
  String toString() {
    return '''
BankAccountResponse(

account: $account

bank: $bank

customer: $customer

features: $features
)''';
  }
}
