# LifeXP

LifeXP is a gamified productivity application designed for students and young adults. It combines task tracking, verification workflows, XP systems, streaks, and achievement tracking into a mobile-first experience.

## Project status

This repository is currently in Phase 1: foundation and project setup.

## Tech stack

- Flutter + Dart
- Firebase Authentication
- Cloud Firestore
- Firebase Cloud Messaging
- flutter_local_notifications
- Riverpod
- GoRouter
- fl_chart

## Current structure

- `lib/core` – app shell, theme, constants, routing
- `lib/features` – feature-first modules for auth, tasks, verification, achievements, dashboard, profile
- `docs/` – assumptions and phase documentation
- `firestore.rules` – secure Firestore access rules template
- `firestore.indexes.json` – Firestore indexes template

## Setup

1. Install Flutter.
2. Run `flutter pub get`.
3. Configure Firebase with FlutterFire CLI:
   `dart pub global activate flutterfire_cli`
   `flutterfire configure`
4. Add `google-services.json` and `GoogleService-Info.plist` for Android and iOS respectively.
5. Run the app:
   `flutter run`

## Screens included in this phase

- onboarding
- login
- registration
- dashboard
- tasks
- verification queue
- achievements
- profile

## Documentation

- [docs/ASSUMPTIONS.md](docs/ASSUMPTIONS.md)
- [docs/PHASE_1_SETUP.md](docs/PHASE_1_SETUP.md)
- [docs/INSTALLATION.md](docs/INSTALLATION.md)
- [docs/CHANGELOG.md](docs/CHANGELOG.md)

## Assumptions

The project intentionally keeps Firebase credentials and environment values out of version control. See the assumptions document for the full project boundary information.
