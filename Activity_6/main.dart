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

import 'dart:convert';
import 'dart:io';

import 'models/account.dart';
import 'models/bank_account_response.dart';

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

  // Read JSON file
  final file = File('data/account_response.json');
  final jsonString = file.readAsStringSync();

  // Convert JSON String to Map
  final Map<String, dynamic> jsonData = jsonDecode(jsonString);

  // Convert JSON Map into the data model
  final bankAccount = BankAccountResponse.fromJson(jsonData);

  print('''

===========================================
# Deserialized JSON:
''');

  printBankAccount(bankAccount);

  // Convert model back into JSON
  final Map<String, dynamic> outputJson = bankAccount.toJson();

  print('''

===========================================
# Serialized JSON:
''');
  print(jsonEncode(outputJson));

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

  print('Account == Same Account: ${bankAccount.account == sameAccount}');
  print(
    'Account hashCode == Same Account hashCode: '
    '${bankAccount.account.hashCode == sameAccount.hashCode}',
  );

  // copyWith
  final updatedAccount = bankAccount.account.copyWith(balance: 15000.0);

  print('''

===========================================
# Using the copyWith function:
''');

  print('Before: ${bankAccount.account}');
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
