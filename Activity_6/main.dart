// ## 🎯 Activity 6
// Remake your first activity (data model) by creating a new data model to handle this json response.
// {
//   "account": {
//     "accountNumber": "000123456789",
//     "accountName": "Juan Dela Cruz",
//     "accountType": "Savings",
//     "currency": "PHP",
//     "balance": 10000.0,
//     "availableBalance": 9500.0,
//     "status": "Active",
//     "openedDate": "2025-01-15"
//   },
//   "bank": {
//     "bankName": "Sample Bank",
//     "branch": "Main Branch",
//     "branchCode": "0001"
//   },
//   "customer": {
//     "customerId": "CUST-00123",
//     "firstName": "Juan",
//     "middleName": "Santos",
//     "lastName": "Dela Cruz"
//   },
//   "features": {
//     "onlineBanking": true,
//     "mobileBanking": true,
//     "cashIn": true,
//     "cashOut": true
//   }
// }

import 'models/account.dart';
import 'models/bank.dart';
import 'models/bank_account_response.dart';
import 'models/customer.dart';
import 'models/features.dart';

void printBankAccount(BankAccountResponse response) {
  print(response.toString());
}

void main() {
  print('''

===========================================
                ACTIVITY 6
        Data Models & JSON Response
===========================================
Submitted by: Alyssa Rhenoa Nicole Bautista
''');

  final account = Account(
    accountNumber: '000123456789',
    accountName: 'Juan Dela Cruz',
    accountType: 'Savings',
    currency: 'PHP',
    balance: 10000.0,
    availableBalance: 9500.0,
    status: 'Active',
    openedDate: '2025-01-15',
  );

  final bank = Bank(
    bankName: 'Sample Bank',
    branch: 'Main Branch',
    branchCode: '0001',
  );

  final customer = Customer(
    customerId: 'CUST-00123',
    firstName: 'Juan',
    middleName: 'Santos',
    lastName: 'Dela Cruz',
  );

  final features = Features(
    onlineBanking: true,
    mobileBanking: true,
    cashIn: true,
    cashOut: true,
  );

  final bankAccount = BankAccountResponse(
    account: account,
    bank: bank,
    customer: customer,
    features: features,
  );

  print('''

===========================================
# Bank Account Response:
''');

  printBankAccount(bankAccount);

  // Comparing models
  final sameAccount = Account(
    accountNumber: '000123456789',
    accountName: 'Juan Dela Cruz',
    accountType: 'Savings',
    currency: 'PHP',
    balance: 10000.0,
    availableBalance: 9500.0,
    status: 'Active',
    openedDate: '2025-01-15',
  );

  print('''

===========================================
# Comparing models:
''');

  print('Account == Same Account: ${account == sameAccount}');
  print(
    'Account hashCode == Same Account hashCode: '
    '${account.hashCode == sameAccount.hashCode}',
  );

  // copyWith
  final updatedAccount = account.copyWith(balance: 15000.0);

  print('''

===========================================
# Using the copyWith function:
''');

  print('Before: $account');
  print('After: $updatedAccount');

  // Update root model
  final updatedBankAccount = bankAccount.copyWith(account: updatedAccount);

  print('''

===========================================
# Updated Bank Account Response:
''');

  printBankAccount(updatedBankAccount);

  print('\n');
}

// Use `dart run main.dart`
