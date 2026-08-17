// ## 🎯 Activity 1
// Practice basic dart syntax:

// 1️⃣ Create a basic data model consisting of (string, int, bool).
// 2️⃣ Ensure immutability (use final keywords)
class Cake {
  // Once Cake is created, these fields can't be reassigned
  // Because of the 'final' keyword
  final String flavor;
  final int quantity;
  final bool isAvailable;

  const Cake({
    required this.flavor,
    required this.quantity,
    required this.isAvailable,
  });

  // 3️⃣ Add copyWith function. (to make updating easier)
  Cake copyWith({
    String? flavor,
    int? quantity,
    bool? isAvailable,
    // Each parameter is optional (?) so if there's no value
    // falls back to the current value after ?? (null-coalescing) operator
  }) {
    return Cake(
      flavor: flavor ?? this.flavor,
      quantity: quantity ?? this.quantity,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  // 4️⃣ Override == and hashcode (for model comparison)
  @override
  bool operator ==(Object other) {
    if (identical(this, other))
      return true; //if the same object, skip field checks
    return other is Cake &&
        other.flavor == flavor &&
        other.quantity == quantity &&
        other.isAvailable == isAvailable;
  }

  @override
  int get hashCode => Object.hash(flavor, quantity, isAvailable);
  //Dart's built-in helper for combining multiple fields into one hash code

  // 5️⃣ Create a function that accepts the model as parameter then prints the toString function.
  @override
  String toString() {
    return 'Cake(flavor: $flavor, quantity: $quantity, isAvailable: $isAvailable)';
  }
}

void printCake(Cake cake) {
  print(cake.toString());
}

// 6️⃣ In your void main, create 5 data models, store it in an array.
void main() {
  List<Cake> cakes = [
    Cake(flavor: 'Black Forest Cake', quantity: 10, isAvailable: true),
    Cake(flavor: 'Chocolate Bliss Cake', quantity: 5, isAvailable: true),
    Cake(flavor: 'Ube Bloom Cake', quantity: 0, isAvailable: false),
    Cake(flavor: 'Tiramisu Cloud Cake', quantity: 8, isAvailable: true),
    Cake(flavor: 'Chocolate Mousse Cake', quantity: 3, isAvailable: true),
  ];

  print('''

===========================================
                ACTIVITY 1
        Practice Basic Dart Syntax
===========================================
Submitted by: Alyssa Rhenoa Nicole Bautista
''');

  // 7️⃣ Iterate over the array and call the function. (should print toString() 5x)
  print('\n# This is the list of Cakes:');
  for (var cake in cakes) {
    printCake(cake);
  }

  // 8️⃣ In your void main after iteration block, compare index 1 and index 2.
  // Index 3 to index 5. Index 4 to index 4. (this is to test hashcode)
  print('\n# Comparing hashcode:');
  print('Cake 1 == Cake 2: ${cakes[0] == cakes[1]}');
  print('Cake 3 == Cake 5: ${cakes[2] == cakes[4]}');
  print('Cake 4 == Cake 4: ${cakes[3] == cakes[3]}');

  // 9️⃣ Use copyWith function to modify the int value. Print the results after. (for testing copyWith)
  Cake updated = cakes[0].copyWith(
    quantity: 20,
  ); //Copy all original values but replace quantity
  print('\n# Using the copyWith function:');
  print('Before:  ${cakes[0]}');
  print('After:   $updated');
  print('\n');
}

// Use `dart run main.dart`
// console prints will show up in the terminal after the CLI
// pretty neat, reminds me of C#
