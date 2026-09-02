# 🔰 Flutter Guide — Questionnaire Reviewer

A study companion for the conceptual questions in the Flutter Guide, with **Post Activity Insights** as recap checkpoints — each bullet now paired with a short code example showing exactly what it looked like in practice.

---

## 1. What is Flutter SDK?

**Flutter vs Native — pros and cons**

- Dart + Flutter = cross-platform development
- Kotlin = native Android development
- Swift = native iOS development

|                             | Flutter                                                                                                                    | Native (Kotlin/Swift)                                      |
| --------------------------- | -------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| Codebase                    | One codebase → iOS + Android                                                                                               | Separate codebase per platform                             |
| Performance                 | Compiles to native ARM code (via Skia/Impeller rendering engine), very close to native, but still an extra rendering layer | Direct access to platform APIs, typically fastest possible |
| Development speed           | Fast — hot reload, shared UI/business logic                                                                                | Slower — duplicate work across platforms                   |
| UI consistency              | Pixel-perfect same UI on both platforms                                                                                    | UI can subtly differ per platform                          |
| Access to new platform APIs | May lag behind — needs a plugin or platform channel                                                                        | Immediate access to latest OS features                     |
| App size                    | Slightly larger (bundles the Flutter engine)                                                                               | Smaller, platform-optimized                                |
| Team/cost                   | One team, one skillset, cheaper long-term                                                                                  | Two teams (or two skillsets), costlier                     |

**Core advantage for a mobile app like PalawanPay**
Think about what a fintech/e-wallet company actually needs:

- **Speed to market** — one team ships iOS and Android simultaneously instead of double the work.
- **Consistent UX/branding** — a wallet app needs identical behavior and look on both platforms (compliance, trust, support consistency).
- **Cost efficiency** — one codebase = smaller dev team, easier maintenance, faster bug fixes (a security fix ships to both platforms at once).
- **Fast iteration** — hot reload speeds up building/testing new features (promos, new payment rails, etc.).

_When you answer this in your assessment, tie it back to business reasons (cost, speed, consistency) — not just "it's easier to code."_

---

## 2. What is Dart Language?

**Fundamentals to know cold:**

- **Variables:** `var`, `final`, `const` — know the difference (`final` = set once at runtime, `const` = compile-time constant).
- **Conditions:** `if/else`, `switch`, ternary `? :`, null-aware operators `??`, `??=`, `?.`.
  - `??` — if null, use a fallback
  - `??=` — assign only if null
  - `?..` — null-aware cascade (lets you perform multiple operations only if the object isn't null)
- **Classes:** constructors (default, named, factory), `this.field` shorthand, inheritance (`extends`), interfaces (`implements`), mixins (`with`).
- **Abstract classes:** classes that can't be instantiated directly, used to define a contract for subclasses (e.g., a `Repository` abstract class with `getData()` that concrete classes implement).
- **Functions:** named/positional/optional parameters, arrow functions (`=>`), anonymous functions, closures.
- **Async:** `Future`, `async`/`await`, `Stream`, `async*`, `Future.wait()` for parallel calls.

**Null safety**
Dart's type system distinguishes nullable (`String?`) from non-nullable (`String`) types at compile time. This prevents null reference errors at runtime by forcing you to handle the null case explicitly (via `?.`, `??`, `!`, or null checks) before the code compiles. It shifts a common runtime crash into a compile-time warning/error.

**Dart vs JavaScript vs TypeScript**

| Aspect        | Dart                                        | JavaScript                                | TypeScript                                         |
| ------------- | ------------------------------------------- | ----------------------------------------- | -------------------------------------------------- |
| Typing        | Statically typed (sound null safety)        | Dynamically typed                         | Statically typed (via annotations, compiles to JS) |
| Compilation   | Compiles to native/ARM (mobile) or JS (web) | Interpreted/JIT                           | Transpiles to JS                                   |
| OOP           | Class-based, similar to Java/C#             | Prototype-based (classes are sugar)       | Class-based like Dart, built on JS prototypes      |
| Async         | `Future`/`async`/`await`, `Stream`          | `Promise`/`async`/`await`                 | Same as JS                                         |
| Null handling | Built-in sound null safety                  | No native null safety (undefined vs null) | Optional strict null checks (`strictNullChecks`)   |

**Similarities:** both Dart and TS use `async/await`, arrow functions, interfaces/classes, and are designed to catch errors before runtime compared to plain JS. **Key difference:** Dart's null safety is baked into the language and enforced by the compiler; TypeScript's is optional/configurable and can still be bypassed at runtime since it compiles down to plain JS.

### ✅ Activity 1 recap — Post Activity Insights (with code)

**1. Create basic data models**

```dart
class Person {
  final String name;
  final int age;
  final bool isActive;

  const Person({
    required this.name,
    required this.age,
    required this.isActive,
  });
```

**2. Ensure immutability + copyWith + override `==`/`hashCode`/`toString`**

```dart
  Person copyWith({String? name, int? age, bool? isActive}) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Person &&
      other.name == name &&
      other.age == age &&
      other.isActive == isActive;

  @override
  int get hashCode => Object.hash(name, age, isActive);

  @override
  String toString() => 'Person(name: $name, age: $age, isActive: $isActive)';
}
```

**3. Understand loops and iteration + log output via `print`**

```dart
void printPerson(Person p) => print(p.toString());

void main() {
  final people = [
    const Person(name: 'Ana', age: 25, isActive: true),
    const Person(name: 'Ben', age: 30, isActive: false),
    const Person(name: 'Cy', age: 22, isActive: true),
    const Person(name: 'Dan', age: 28, isActive: false),
    const Person(name: 'Eve', age: 35, isActive: true),
  ];

  for (var p in people) {
    printPerson(p); // toString() called 5x, one per loop iteration
  }
```

**4. Use conditional statements (testing hashcode/equality between indices)**

```dart
  print(people[1] == people[2]); // false — different name/age/isActive
  print(people[3] == people[4]); // false — different values
  print(people[4] == people[4]); // true — same object, same hashCode

  if (people[1].hashCode == people[2].hashCode) {
    print('Same hash — likely equal objects');
  } else {
    print('Different hash — definitely not equal');
  }
```

**5. Use copyWith to modify and print results**

```dart
  final updated = people[0].copyWith(age: 26);
  print(updated); // Person(name: Ana, age: 26, isActive: true)
}
```

---

## 3. What is a Widget?

- **Stateless vs Stateful:**
  - `StatelessWidget` — immutable, doesn't hold data that changes over time; rebuilds only when its parent rebuilds or its constructor input changes. Use for static UI (icons, labels, static layouts).
  - `StatefulWidget` — has a mutable `State` object that persists across rebuilds via `setState()`. Use when the widget needs to change appearance in response to user interaction, data, or animation.

- **When to use which:** if the widget's appearance never changes after being built → Stateless. If it needs to respond to interaction/data changes internally (toggle, form field, counter) → Stateful.

- **Widget lifecycle (Stateful):** `createState()` → `initState()` → `build()` → (`setState()` triggers rebuild) → `didUpdateWidget()` (if parent rebuilds it with new config) → `dispose()` (cleanup, e.g., closing streams/controllers).

- **Widget Tree:** Flutter UI is a nested tree of widgets (parent-child). Understanding it matters because widget position determines rebuild scope, context (`BuildContext`) inheritance, and how state/data (e.g., `InheritedWidget`, Provider) flows down the tree.

- **Types of widgets:** Structural (`Scaffold`, `Column`, `Row`, `Container`), Stateless/Stateful, Inherited widgets (data-sharing), Layout widgets (`Padding`, `Expanded`, `Stack`), and Platform-adaptive widgets (Material vs Cupertino).

- **Adding properties:** define fields in the widget class, pass them via the constructor (usually with `required` for non-nullable, non-default fields), and reference `widget.propertyName` inside the `State` class if it's a `StatefulWidget`.

### ✅ Activity 2 recap — Post Activity Insights (with code)

**1. Familiarization of basic widgets (small building block)**

```dart
class AppIcon extends StatelessWidget {
  final IconData icon;
  const AppIcon(this.icon, {super.key});

  @override
  Widget build(BuildContext context) => Icon(icon, size: 20);
}
```

**2. Systematic reusable widgets, composed together (medium block reusing small blocks)**

```dart
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoRow({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIcon(icon), // reusing the small widget instead of duplicating an Icon()
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
```

**3. Layout a screen from a reference image (large block, combining Scaffold/SafeArea/SingleChildScrollView)**

```dart
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // makes the layout scrollable
          child: Column(
            children: const [
              InfoRow(icon: Icons.email, label: 'juan@email.com'),
              InfoRow(icon: Icons.phone, label: '0917 000 0000'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
```

**4. Edit widget properties based on what's needed**

```dart
// Same InfoRow widget, reused with different property values per use case
const InfoRow(icon: Icons.location_on, label: 'Quezon City, PH')
const InfoRow(icon: Icons.badge, label: 'Employee ID: 00123')
```

---

## 4. What is State Management?

- **Why it matters:** as an app grows, passing data manually through many widget constructors ("prop drilling") becomes unmanageable. State management provides a structured way to store, update, and share app data (state) across widgets without tightly coupling UI to logic.

- **Separating business logic from UI:** state management patterns (like BLOC/Cubit, Provider, Riverpod) move data-fetching, validation, and business rules out of widget `build()` methods and into dedicated classes. The UI only _listens_ to state and _dispatches_ events/actions — it doesn't contain the logic itself. This makes code more testable (you can unit test business logic without rendering UI), reusable, and easier to maintain.

### ✅ Activity 3 recap — Post Activity Insights (with code)

**1. Familiarization of forms, textfields, and dropdown widgets**

```dart
TextFormField(
  decoration: const InputDecoration(labelText: 'First Name'),
  onChanged: (value) => setState(() => model = model.copyWith(firstName: value)),
),
DropdownButtonFormField<String>(
  decoration: const InputDecoration(labelText: 'Gender'),
  items: const [
    DropdownMenuItem(value: 'Male', child: Text('Male')),
    DropdownMenuItem(value: 'Female', child: Text('Female')),
  ],
  onChanged: (value) => setState(() => model = model.copyWith(gender: value)),
),
```

**2. Usage of StatefulWidget + setState + data model for cleaner logic**

```dart
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  RegistrationModel model = RegistrationModel(); // keeps form data in one clean object

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ...TextFormField and DropdownButtonFormField from above...
      ],
    );
  }
}
```

**3. Conditional statements to control button enablement**

```dart
  bool get isComplete =>
      model.firstName.isNotEmpty &&
      model.lastName.isNotEmpty &&
      model.gender != null &&
      model.nationality != null;

  // in build():
  ElevatedButton(
    onPressed: isComplete ? _goToNext : null, // null disables the button
    child: const Text('Next'),
  ),
```

---

## 5. What is a BLoC? (Business Logic Component)

- **Why BLOC:** enforces a strict, predictable, testable separation between UI and business logic using a unidirectional data flow:
  `UI → Event → BLOC → State → UI`

- **Primary ingredients:**
  - **Events** — inputs describing _what happened_ (e.g., `SubmitFormEvent`).
  - **States** — outputs describing _what the UI should show_ (e.g., `FormLoading`, `FormSuccess`, `FormFailure`).
  - **Bloc** — maps incoming events to outgoing states, usually containing the business logic (or delegating to a repository).
  - **Repository** — abstracts data sources (API, local storage, database) away from the BLOC, so the BLOC doesn't care _where_ data comes from.
  - **Listener/Builder** — widgets (`BlocListener`, `BlocBuilder`, `BlocConsumer`) that react to state changes: `BlocBuilder` rebuilds UI, `BlocListener` performs side effects (navigation, dialogs) without rebuilding.

- **Cubit:** a simplified version of Bloc — no separate `Event` classes; you call methods directly on the Cubit to emit new states. Use Cubit when the logic is simple and you don't need the fine-grained event traceability that full Bloc provides (e.g., simple toggles, straightforward form submissions). Use full Bloc when you want strict event-driven architecture, easier debugging/tracing of "what caused this state," or more complex flows (e.g., event transformations, debouncing).
  `UI → Cubit → State → UI`

- Cubit = direct actions → new state
  BLoC = events → logic → new state

---

## 6. Local Storage

- **Why SharedPreferences:** for storing small amounts of simple key-value data (strings, ints, bools) that should persist across app restarts — e.g., "has the user seen onboarding," theme preference, last-used tab. It writes to a simple, unencrypted file on device.

- **How to use it:** get the `SharedPreferences` instance asynchronously (`SharedPreferences.getInstance()`), then use typed setters/getters (`setString`, `getString`, `setBool`, `getInt`, etc.) with a string key.

- **Flutter Secure Storage:** wraps platform-native secure storage — **Keychain** on iOS, **Keystore/EncryptedSharedPreferences** on Android — to store sensitive data **encrypted at rest**. Unlike SharedPreferences, its contents aren't easily readable if the device is rooted/jailbroken or the file system is inspected.

- **Why Palawan (a fintech app) needs Secure Storage over SharedPreferences:** SharedPreferences stores data in **plain text**. For a financial app, storing tokens, account numbers, PINs, or session credentials in plain text is a serious security risk (data theft on rooted devices, reverse engineering, compliance failure with financial data regulations like BSP requirements in the Philippines). Secure Storage protects sensitive data at rest via hardware-backed encryption, which is essential for anything auth- or money-related. Non-sensitive preferences (like UI settings) can still safely use SharedPreferences.

### ✅ Activity 4 recap — Post Activity Insights (with code)

**1. Understand SharedPreferences: how, why, and where to use it**

```dart
class PreferenceHelper {
  Future<void> saveSharedPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> readSharedPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key); // null if nothing was ever saved
  }
}
```

**2. Familiarization in creating reusable helper functions (used from the UI)**

```dart
class PersistenceScreen extends StatefulWidget {
  const PersistenceScreen({super.key});
  @override
  State<PersistenceScreen> createState() => _PersistenceScreenState();
}

class _PersistenceScreenState extends State<PersistenceScreen> {
  final helper = PreferenceHelper(); // reused across the screen
  String? savedValue;

  @override
  void initState() {
    super.initState();
    helper.readSharedPreference('demo_key').then((value) {
      setState(() => savedValue = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (savedValue != null) Text(savedValue!), // only shown if a value exists
        ElevatedButton(
          onPressed: () async {
            await helper.saveSharedPreference('demo_key', 'default value');
            setState(() => savedValue = 'default value');
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
```

---

## 7. Navigation and Routing

- **Navigator methods:**
  - `Navigator.push()` — pushes a new route onto the stack (goes forward, keeps the previous screen underneath).
  - `Navigator.pop()` — removes the current route, returning to the previous screen (used for "back" actions or returning a result).
  - `Navigator.pushNamed()` — like `push`, but references a route by a registered string name instead of building the widget inline.
  - `Navigator.pushReplacementNamed()` — replaces the current route with a new named one (previous screen is removed from the stack) — useful for things like login → home, where you don't want "back" to return to login.
  - Others: `pushAndRemoveUntil` (clear stack down to a condition, e.g., logout flow), `popUntil` (pop back to a specific route).

- **`Navigator.of(context).pop()` vs `Navigator.pop(context)`:** functionally identical — `Navigator.pop(context)` is shorthand that internally calls `Navigator.of(context).pop()`. Both look up the nearest `Navigator` in the widget tree via `context` and pop it.

- **Named routes:** routes registered by string identifier (typically in `MaterialApp(routes: {...})` or via a route generator), letting you navigate with `Navigator.pushNamed(context, '/details')` instead of manually constructing the destination widget each time. Useful for centralizing route definitions, deep linking, and decoupling navigation from widget construction.

### ✅ Activity 5 recap — Post Activity Insights (with code)

**1. Understand screen navigation and routing**

```dart
// Welcome screen's Start button
ElevatedButton(
  onPressed: () => Navigator.pushNamed(context, '/form'),
  child: const Text('Start'),
),

// Back button on details screen
ElevatedButton(
  onPressed: () => Navigator.pop(context), // returns to Welcome
  child: const Text('Back'),
),
```

**2. Using BLOC as state management (events + states)**

```dart
abstract class RegistrationEvent {}
class SubmitRegistration extends RegistrationEvent {
  final RegistrationModel data;
  SubmitRegistration(this.data);
}

abstract class RegistrationState {}
class RegistrationInitial extends RegistrationState {}
class RegistrationSuccess extends RegistrationState {}
class RegistrationFailure extends RegistrationState {}
```

**3. Using BLOC classes to access the Activity 4 helper function**

```dart
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final PreferenceHelper helper; // the Activity 4 helper, injected here
  RegistrationBloc(this.helper) : super(RegistrationInitial()) {
    on<SubmitRegistration>((event, emit) async {
      final isEven = Random().nextInt(100) % 2 == 0; // int randomizer
      if (isEven) {
        await helper.saveSharedPreference('registration', event.data.toString());
        emit(RegistrationSuccess());
      } else {
        emit(RegistrationFailure());
      }
    });
  }
}
```

**4. Invoking BLOC events via `.add()` (refactored Next button)**

```dart
ElevatedButton(
  onPressed: isComplete
      ? () => context.read<RegistrationBloc>().add(SubmitRegistration(model))
      : null,
  child: const Text('Next'),
),
```

**5. Using BlocListener to access BLOC states and navigate**

```dart
BlocListener<RegistrationBloc, RegistrationState>(
  listener: (context, state) {
    if (state is RegistrationSuccess) {
      Navigator.pushNamed(context, '/success'); // shows the saved value
    } else if (state is RegistrationFailure) {
      Navigator.pushNamed(context, '/failed'); // try again
    }
  },
  child: const RegistrationForm(),
),
```

---

## 8. Network & API

- **http package:** Dart/Flutter's standard library for making HTTP requests (GET, POST, PUT, DELETE) to REST APIs. Returns `Future<Response>` objects containing status code, headers, and body.

- **JSON:** JavaScript Object Notation — a lightweight, human-readable, text-based data format using key-value pairs, arrays, strings, numbers, booleans, and null. It's the standard format for API request/response bodies.

- **JSON serialization:** converting a Dart object into a JSON-compatible format (`toJson()` — object → `Map<String, dynamic>` → JSON string) for sending data, and **deserialization** is the reverse (`fromJson()` — JSON/Map → Dart object) for reading API responses into usable typed objects.

- **POST vs GET:**

|               | GET                                            | POST                                                  |
| ------------- | ---------------------------------------------- | ----------------------------------------------------- |
| Purpose       | Retrieve data                                  | Send/create data                                      |
| Data location | URL query parameters                           | Request body                                          |
| Caching       | Can be cached                                  | Not typically cached                                  |
| Idempotent    | Yes (same call = same result)                  | No (each call can create new data)                    |
| Body size     | Limited (URL length limits)                    | Can send large payloads                               |
| Use case      | Fetching account balance, list of transactions | Submitting a registration form, initiating a transfer |

### ✅ Activity 6 recap — Post Activity Insights (with code)

**1. Understand JSON format and why we use it**

```json
{
  "account": { "accountNumber": "000123456789", "balance": 10000.0 },
  "bank": { "bankName": "Sample Bank", "branchCode": "0001" }
}
```

_Key-value, nested, language-agnostic — this is the shape any Dart model below must be able to read and produce._

**2. What, why, and where to use JSON serialization and deserialization**

```dart
class Account {
  final String accountNumber;
  final double balance;

  Account({required this.accountNumber, required this.balance});

  // Deserialization: JSON (Map) -> Dart object
  factory Account.fromJson(Map<String, dynamic> json) => Account(
        accountNumber: json['accountNumber'],
        balance: (json['balance'] as num).toDouble(),
      );

  // Serialization: Dart object -> JSON (Map)
  Map<String, dynamic> toJson() => {
        'accountNumber': accountNumber,
        'balance': balance,
      };
}

class Bank {
  final String bankName;
  final String branchCode;

  Bank({required this.bankName, required this.branchCode});

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        bankName: json['bankName'],
        branchCode: json['branchCode'],
      );

  Map<String, dynamic> toJson() => {
        'bankName': bankName,
        'branchCode': branchCode,
      };
}

class AccountResponse {
  final Account account;
  final Bank bank;

  AccountResponse({required this.account, required this.bank});

  factory AccountResponse.fromJson(Map<String, dynamic> json) => AccountResponse(
        account: Account.fromJson(json['account']),
        bank: Bank.fromJson(json['bank']),
      );

  Map<String, dynamic> toJson() => {
        'account': account.toJson(),
        'bank': bank.toJson(),
      };
}
```

---

## 9. Activity 7 — Bringing it all together (Scryfall or PokéAPI)

There's no separate conceptual question set for this one — it's a capstone activity combining _everything_ above.

- **New concepts introduced (not covered elsewhere in the guide, worth reviewing separately if unfamiliar):**
  - **Triggered search** — firing a BLOC search event on keyboard "search"/"go"/"ok" rather than on every keystroke.
  - **Infinite scroll pagination** (Option B) — detecting scroll-end and incrementing an `offset` parameter to append more results to an existing list, without duplicate calls or duplicate items.

### ✅ Activity 7 (A & B) recap — Post Activity Insights (with code)

**1. Understand how API responses translate to UI screens**

```dart
class CardModel {
  final String name;
  final String imageUrl;

  CardModel({required this.name, required this.imageUrl});

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        name: json['name'],
        imageUrl: json['image_uris']?['normal'] ?? '',
      );
}
// Every field here exists because a specific widget needs it —
// `name` -> Text, `imageUrl` -> Image.network in the list item.
```

**2. Creating effective data models according to your use case**

```dart
// PokéAPI list vs detail need different, purpose-built shapes —
// don't force one bloated model to do both jobs.
class PokemonListItem {
  final String name;
  final String url; // used to fetch full detail later
  PokemonListItem({required this.name, required this.url});

  factory PokemonListItem.fromJson(Map<String, dynamic> json) =>
      PokemonListItem(name: json['name'], url: json['url']);
}

class PokemonDetail {
  final String name;
  final int height;
  final int weight;
  final List<String> types;

  PokemonDetail({
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => PokemonDetail(
        name: json['name'],
        height: json['height'],
        weight: json['weight'],
        types: (json['types'] as List)
            .map((t) => t['type']['name'] as String)
            .toList(),
      );
}
```

**3. Properly implement screen navigation (list → detail, with data passed along)**

```dart
ListTile(
  title: Text(card.name),
  onTap: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => CardDetailScreen(card: card)),
  ),
),
```

**4. Utilizing BLOC state management to control data and UI**

```dart
abstract class CardEvent {}
class SearchCards extends CardEvent {
  final String query;
  SearchCards(this.query);
}

abstract class CardState {}
class CardLoading extends CardState {}
class CardEmpty extends CardState {}
class CardLoaded extends CardState {
  final List<CardModel> cards;
  CardLoaded(this.cards);
}

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardLoading()) {
    on<SearchCards>((event, emit) async {
      emit(CardLoading());
      final response = await http.get(
        Uri.parse('https://api.scryfall.com/cards/search?q=${event.query}'),
      );
      final data = jsonDecode(response.body);
      final cards = (data['data'] as List).map((e) => CardModel.fromJson(e)).toList();
      emit(cards.isEmpty ? CardEmpty() : CardLoaded(cards));
    });
  }
}

// UI reacting to state:
BlocBuilder<CardBloc, CardState>(
  builder: (context, state) {
    if (state is CardLoading) return const CircularProgressIndicator();
    if (state is CardEmpty) return const Text('No cards found');
    if (state is CardLoaded) {
      return ListView.builder(
        itemCount: state.cards.length,
        itemBuilder: (context, index) => ListTile(title: Text(state.cards[index].name)),
      );
    }
    return const SizedBox.shrink();
  },
),
```

**5. End-to-end development (the full flow, wired together)**

```dart
// Search bar triggers the event on keyboard "search"/"go"/"ok"
TextField(
  textInputAction: TextInputAction.search,
  onSubmitted: (query) => context.read<CardBloc>().add(SearchCards(query)),
),

// The rest of the flow: SearchCards event -> CardBloc calls the API
// -> emits CardLoading/CardEmpty/CardLoaded -> BlocBuilder renders the list
// -> tapping an item navigates to CardDetailScreen with the tapped card's data.
// That's the complete API -> model -> BLOC -> UI -> navigation loop.
```

---

## Quick self-check before your assessment

- Can you explain **why**, not just **what**, for each concept? (e.g., not just "BLOC has events and states," but _why_ that separation exists.)
- Can you connect each topic back to the PalawanPay context where the guide hints at it (Flutter choice, Secure Storage)? Those are the "Additional Thoughts" questions and are likely where deeper reasoning is expected.
- Can you explain the _trade-offs_ (Stateless vs Stateful, Cubit vs Bloc, SharedPreferences vs Secure Storage, GET vs POST) rather than just definitions?
- Can you write each code example above **from memory**, without looking at your original activity files? If you can reproduce the pattern (not the exact variable names) on a blank screen, that's a strong sign you're ready.
