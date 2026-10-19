# Phase 1 – Project setup and foundation

## Objective

This phase establishes the project skeleton for LifeXP, including the Flutter app shell, theming, routing, folder structure, and the configuration conventions required for later Firebase and feature implementation.

## Included in this phase

- Updated Flutter app bootstrap for a Material 3 life-cycle shell
- Project-level dependency setup for Firebase, Riverpod, GoRouter, notifications, and charting
- Feature-first folder structure under `lib/`
- Base routing for onboarding, auth, dashboard, tasks, verification, achievements, and profile
- Early architecture docs and assumptions file
- Firestore rule and index placeholders for later implementation

## Key files created

- `lib/main.dart`
- `lib/core/app.dart`
- `lib/core/router/app_router.dart`
- `lib/core/theme/app_theme.dart`
- `lib/features/shared/app_shell.dart`
- `docs/ASSUMPTIONS.md`
- `firestore.rules`
- `firestore.indexes.json`

## Firebase configuration notes

The app is intentionally prepared for FlutterFire configuration without committing any secret or project-specific credentials.

1. Install FlutterFire CLI:
   `dart pub global activate flutterfire_cli`
2. Run:
   `flutterfire configure`
3. Add the generated Firebase files to the project as required by the platform.
4. Keep `google-services.json` and `GoogleService-Info.plist` outside the repository or store them according to the project security policy.

## Validation performed

- Flutter dependencies were prepared for installation.
- The project shell was structured to be analyzer-friendly and ready for the next feature phase.
- The default template code was replaced with a clean app scaffold so the next phases can build on a stable base.

## Next phase

Phase 2 will add authentication, roles, and the profile layer, followed by task management and verification workflows in subsequent phases.
