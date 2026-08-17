# 🔰 Flutter Guide — Questionnaire Reviewer

A study companion for the conceptual questions in the Flutter Guide (activities excluded).

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
  - `?..` — null-aware cascade (This lets you perform multiple operations only if the object isn't null.)

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

**Similarities:** both Dart and TS use `async/await`, arrow functions, interfaces/classes, and are designed to catch errors before runtime compared to plain JS.

**Key difference:** Dart's null safety is baked into the language and enforced by the compiler; TypeScript's is optional/configurable and can still be bypassed at runtime since it compiles down to plain JS.

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

---

## 4. What is State Management?

- **Why it matters:** as an app grows, passing data manually through many widget constructors ("prop drilling") becomes unmanageable. State management provides a structured way to store, update, and share app data (state) across widgets without tightly coupling UI to logic.

- **Separating business logic from UI:** state management patterns (like BLOC/Cubit, Provider, Riverpod) move data-fetching, validation, and business rules out of widget `build()` methods and into dedicated classes. The UI only _listens_ to state and _dispatches_ events/actions — it doesn't contain the logic itself. This makes code more testable (you can unit test business logic without rendering UI), reusable, and easier to maintain.

---

## 5. What is a BLoC? (Business Logic Component)

- **Why BLOC:** enforces a strict, predictable, testable separation between UI and business logic using a unidirectional data flow:  
  `UI → Event → BLOC → State → UI.`

- **Primary ingredients:**
  - **Events** — inputs describing _what happened_ (e.g., `SubmitFormEvent`).
  - **States** — outputs describing _what the UI should show_ (e.g., `FormLoading`, `FormSuccess`, `FormFailure`).
  - **Bloc** — maps incoming events to outgoing states, usually containing the business logic (or delegating to a repository).
  - **Repository** — abstracts data sources (API, local storage, database) away from the BLOC, so the BLOC doesn't care _where_ data comes from.
  - **Listener/Builder** — widgets (`BlocListener`, `BlocBuilder`, `BlocConsumer`) that react to state changes: `BlocBuilder` rebuilds UI, `BlocListener` performs side effects (navigation, dialogs) without rebuilding.

- **Cubit:** a simplified version of Bloc — no separate `Event` classes; you call methods directly on the Cubit to emit new states. Use Cubit when the logic is simple and you don't need the fine-grained event traceability that full Bloc provides (e.g., simple toggles, straightforward form submissions). Use full Bloc when you want strict event-driven architecture, easier debugging/tracing of "what caused this state," or more complex flows (e.g., event transformations, debouncing).  
  `UI → Cubit → State → UI.`

- Cubit = direct actions → new state  
  BLoC = events → logic → new state

---

## 6. Local Storage

- **Why SharedPreferences:** for storing small amounts of simple key-value data (strings, ints, bools) that should persist across app restarts — e.g., "has the user seen onboarding," theme preference, last-used tab. It writes to a simple, unencrypted file on device.

- **How to use it:** get the `SharedPreferences` instance asynchronously (`SharedPreferences.getInstance()`), then use typed setters/getters (`setString`, `getString`, `setBool`, `getInt`, etc.) with a string key.

- **Flutter Secure Storage:** wraps platform-native secure storage — **Keychain** on iOS, **Keystore/EncryptedSharedPreferences** on Android — to store sensitive data **encrypted at rest**. Unlike SharedPreferences, its contents aren't easily readable if the device is rooted/jailbroken or the file system is inspected.

- **Why Palawan (a fintech app) needs Secure Storage over SharedPreferences:** SharedPreferences stores data in **plain text**. For a financial app, storing tokens, account numbers, PINs, or session credentials in plain text is a serious security risk (data theft on rooted devices, reverse engineering, compliance failure with financial data regulations like BSP requirements in the Philippines). Secure Storage protects sensitive data at rest via hardware-backed encryption, which is essential for anything auth- or money-related. Non-sensitive preferences (like UI settings) can still safely use SharedPreferences.

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

---

## Quick self-check before your assessment

- Can you explain **why**, not just **what**, for each concept? (e.g., not just "BLOC has events and states," but _why_ that separation exists.)
- Can you connect each topic back to the PalawanPay context where the guide hints at it (Flutter choice, Secure Storage)? Those are the "Additional Thoughts" questions and are likely where deeper reasoning is expected.
- Can you explain the _trade-offs_ (Stateless vs Stateful, Cubit vs Bloc, SharedPreferences vs Secure Storage, GET vs POST) rather than just definitions?
