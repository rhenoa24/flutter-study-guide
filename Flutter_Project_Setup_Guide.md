# 🚀 Flutter Project Setup Guide

A repeatable reference for spinning up a new Flutter project from scratch, assuming you already have a GitHub repo created and cloned locally.

---

## 0. Prerequisites (included for completeness)

You likely already have these installed, but here's the full checklist for a fresh machine:

| Tool                                                          | Purpose                               | Check install         |
| ------------------------------------------------------------- | ------------------------------------- | --------------------- |
| **Flutter SDK**                                               | Core framework/toolchain              | `flutter --version`   |
| **Dart SDK**                                                  | Ships bundled with Flutter            | `dart --version`      |
| **Git**                                                       | Version control                       | `git --version`       |
| **Android Studio** (or just Android SDK + command-line tools) | Android emulator, SDK, platform tools | —                     |
| **Xcode** (Mac only, for iOS builds)                          | iOS simulator, CocoaPods              | `xcodebuild -version` |
| **VS Code** or **Android Studio** with Flutter/Dart plugins   | IDE with hot reload support           | —                     |
| **CocoaPods** (Mac only)                                      | iOS dependency manager                | `pod --version`       |

**Run Flutter's built-in doctor to confirm everything is wired up correctly:**

```bash
flutter doctor
```

Fix anything flagged with an ❌ before proceeding (missing Android licenses, missing Xcode command line tools, etc.). Common fix for Android license issues:

```bash
flutter doctor --android-licenses
```

---

## 1. Create the Flutter project

Since you already have a **cloned, empty (or near-empty) GitHub repo**, the cleanest approach is to generate the Flutter project _directly inside_ that folder rather than creating it elsewhere and moving files.

```bash
cd path/to/your-cloned-repo

flutter create . \
  --org com.yourcompany \
  --project-name your_project_name
```

**Flags explained:**

- `.` — tells Flutter to scaffold the project into the **current directory** (your existing repo) instead of creating a new subfolder.
- `--org` — reverse-domain identifier used for Android package name / iOS bundle ID (e.g., `com.palawanpay`).
- `--project-name` — must be `snake_case`, becomes the Dart package name in `pubspec.yaml`.

> ⚠️ If your repo folder already has a `README.md` and other files (like yours does), `flutter create .` will merge the Flutter scaffold into it without overwriting your existing files — Flutter is safe to run in a non-empty directory as long as there's no naming conflict.

**Optional flags you may want:**

```bash
flutter create . \
  --org com.yourcompany \
  --project-name your_project_name \
  --platforms=android,ios \
  --template=app
```

- `--platforms` — limit scaffold to only the platforms you need (skip web/windows/linux/macos if not targeting them, keeps the repo lighter).
- `--template=app` — default; other options are `package`, `plugin`, `module` if you're building something other than a full app.

---

## 2. Verify the project runs

```bash
flutter pub get      # fetch dependencies
flutter doctor        # sanity check again
flutter devices       # confirm an emulator/device is available
flutter run            # launch the default counter app
```

If `flutter run` boots the default counter app on your emulator/device, your setup is good.

---

## 3. Clean up before committing

Flutter auto-generates a `.gitignore` — check it includes at minimum:

```
.dart_tool/
.flutter-plugin-dependencies
build/
.idea/
*.iml
.vscode/
android/local.properties
ios/Flutter/Flutter.podspec
```

If your repo already had its own `.gitignore` (common if the repo started with just a README), merge Flutter's generated one into it rather than replacing it.

Also worth deciding early:

- Delete the boilerplate counter app code in `lib/main.dart` and replace with your own starting point.
- Update `pubspec.yaml`'s `description`, `version`, and remove unused default comments.

---

## 4. Recommended folder structure

A clean starting structure that scales well (adjust to your state-management choice — Bloc/Cubit, Provider, Riverpod, etc.):

```
lib/
├── main.dart
├── app.dart                  # MaterialApp / routes setup
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/             # API clients, local storage helpers
├── presentation/
│   ├── screens/
│   │   └── home/
│   │       ├── home_screen.dart
│   │       ├── bloc/         # or cubit/
│   │       └── widgets/
│   └── shared_widgets/       # reusable widgets across screens
└── routes/
    └── app_routes.dart
```

---

## 5. Common dependencies to add early

Add via terminal (auto-updates `pubspec.yaml`) rather than editing the YAML by hand:

```bash
flutter pub add http                     # networking
flutter pub add shared_preferences       # local key-value storage
flutter pub add flutter_secure_storage   # encrypted local storage
flutter pub add flutter_bloc             # Bloc/Cubit state management
flutter pub add equatable                # value comparison for models/states
```

Dev dependencies (testing/codegen tools):

```bash
flutter pub add --dev build_runner
flutter pub add --dev json_serializable
```

---

## 6. First commit

```bash
git add .
git commit -m "chore: scaffold Flutter project"
git push
```

---

## Quick reference: full setup in one go

```bash
cd path/to/your-cloned-repo
flutter create . --org com.yourcompany --project-name your_project_name --platforms=android,ios
flutter pub get
flutter doctor
flutter run
git add .
git commit -m "chore: scaffold Flutter project"
git push
```

---

## Troubleshooting cheatsheet

| Issue                                            | Fix                                                                                                         |
| ------------------------------------------------ | ----------------------------------------------------------------------------------------------------------- |
| `flutter create` refuses to run in non-empty dir | It's fine unless there's a literal filename conflict (rare) — check the error message for the specific file |
| No devices found                                 | Start an emulator via Android Studio's Device Manager, or run `open -a Simulator` on Mac for iOS            |
| Android license not accepted                     | `flutter doctor --android-licenses`                                                                         |
| CocoaPods errors (iOS)                           | `cd ios && pod install && cd ..`                                                                            |
| Stale build errors after pulling changes         | `flutter clean && flutter pub get`                                                                          |
