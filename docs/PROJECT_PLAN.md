# LifeXP Project Plan

## Project baseline

LifeXP is an Android-first Flutter application using Firebase Authentication, Cloud Firestore, Firebase Cloud Messaging, Riverpod, GoRouter, and local notifications. The repository is an existing app, not a blank Flutter template. Existing Firebase platform configuration is present and will be preserved; the presence of configuration does not establish that Firebase Console services or production permissions are enabled.

### Existing implementation

- `lib/main.dart` initializes Firebase and Riverpod, but passes a one-time authentication boolean into the app.
- `lib/core/` contains a Material 3 app shell, theme, constants, and GoRouter routes.
- `lib/features/auth/` contains email/password registration and sign-in, password-reset email, Firestore profile creation/lookup, and profile update logic. Persistent auth-state routing, a dedicated forgot-password screen, and complete profile/settings UI remain incomplete.
- `lib/features/tasks/`, `verification/`, `dashboard/`, `achievements/`, and `profile/` contain presentation screens, but their displayed tasks, statistics, achievements, and profile are hard-coded; task CRUD and real-time repositories are absent.
- `firestore.rules` and `firestore.indexes.json` exist. Current rules permit users to update broad task/verifications data, permit client-created XP records, and allow a user to update their own `role`-protected user data only by equality but do not yet establish trusted Cloud Function workflows. Rules need a security redesign before enabling real verification/reward flows.
- No Cloud Functions source directory or Firebase Emulator configuration was found in the inspected project structure.
- Android configuration and Firebase Gradle plugin are present. The Android application ID is still the template value `com.example.lifexp_app`; confirm the desired final package ID before store/release distribution.
- `test/widget_test.dart` is a single onboarding smoke test.

## Phase status and implementation order

| Phase | Scope | Status / exit gate |
| --- | --- | --- |
| 0. Inspection and preparation | Inventory, toolchain, dependencies, analysis, tests, Android debug build, this plan | Complete for available local checks. Android SDK licenses need acceptance for full device workflows. |
| 1. Architecture | Refine feature layers, auth-aware routing, shared UI/error/loading patterns, testable providers | Foundation and live auth-aware route guarding are in place; routing transition tests pass. Continue expanding shared state patterns alongside data-backed screens. |
| 2. Firebase backend | Define data contracts, emulator setup, restrictive Firestore rules/indexes, Cloud Functions and trusted repositories | Configuration files exist, but secure backend processing and emulator/functions infrastructure are missing. Requires Firebase project access and Functions deployment setup. |
| 3. Authentication | Auth persistence/routing, registration/login/logout/reset, profile creation/editing, validation and tests | Core Auth calls exist; session routing, profile UX and coverage remain. |
| 4. Task management | Firestore task model/repository, create/edit/archive, filters, deadlines and submission locking | UI is placeholder-only; no task persistence exists. |
| 5. Verification | Verifier invitations/relationships, assignment, inbox/history, secure approve/reject through Functions | UI is placeholder-only; no secure workflow exists. |
| 6. XP and levels | Server-authoritative reward transactions, ledger, deduplication, level calculation and UI | Not implemented. Use the requested formula `floor(totalXP / 100) + 1`; replace the contradictory square-root formula in `docs/ASSUMPTIONS.md`. |
| 7. Streaks and achievements | Timezone-aware productive dates, streak counters, backend unlocks and progress UI | UI uses static sample achievements; backend logic is absent. |
| 8. Dashboard and statistics | Real-time aggregates, weekly productivity and recent activity | Static sample metrics/charts; no data source exists. |
| 9. Notifications | Permission handling, scheduled/canceled local reminders, FCM token/preferences and tests | Packages are present; end-to-end behavior is not established. |
| 10. Administration | Custom-claim checks, restricted admin APIs/UI, documented secure role assignment | Not implemented. Do not grant admin from client-editable profile fields. |
| 11. Testing and hardening | Unit/widget/integration/security tests, emulator scenarios, Android runtime/layout checks | Only the onboarding smoke test currently exists. Firebase-backed scenarios require configured services or emulators. |
| 12. Delivery | User/setup docs, testing report, limitations, screenshots checklist, demonstration APK | Debug APK can be built; release signing and final Firebase deployment remain future gates. |

## Phase 0 verification record

Checked on 2026-10-19 in the current Windows workspace:

- Flutter 3.47.5 stable and Dart 3.13.4 are installed; the declared SDK constraint `^3.13.4` is satisfied.
- `flutter pub get` completed successfully. Existing declared dependencies were retained; package updates were not applied.
- `flutter analyze` completed with no issues.
- `flutter test` passed (one existing widget test).
- `flutter build apk --debug` succeeded and produced `build/app/outputs/flutter-apk/app-debug.apk`.
- `flutter doctor -v` reports Android SDK 36.0.0 installed, with some Android SDK licenses not accepted. No Android emulator/device was connected during inspection. Flutter, Windows desktop, Chrome, Visual Studio, and network checks passed.
- `java -version` on PATH reported Java 23.0.1; Flutter Doctor selected Android Studio's bundled JBR 25.0.3 for Android builds. The debug build succeeded with that selected toolchain.
- Gradle wrapper is 9.3.1; Android Gradle Plugin is 9.1.0; Kotlin Android plugin is 2.4.0; Google Services plugin is 4.3.15.
- The workspace is at `C:\Users\ibrcb\lifexp_app`, not visibly under OneDrive. No project move is indicated.

## Delivery approach and gates

Implement one phase at a time, preserving the existing project and Firebase configuration. Prefer emulator-backed tests for authorization and trusted reward processing; never treat client UI checks as security enforcement. At each phase, format changed Dart code, run focused tests and `flutter analyze`, then build Android when the phase changes app or platform code. Record actual results rather than marking unverified requirements complete.

Before deploying Functions or rules, verify Firebase project access, enabled Authentication providers, Firestore database, billing/plan requirements for Functions, and emulator availability. Before a final release, choose a non-template Android application ID and configure release signing outside source control. No Firebase Console state, production deployment, connected-device behavior, or release APK has been verified in Phase 0.

## Immediate next work

Proceed with Phase 2 by defining server-authoritative data contracts, emulator support, restrictive Firestore rules, and Cloud Functions before implementing task submission, verification, XP, or streak writes. Do not enable the current broad client write rules for production data.

## Phase 1 progress

- GoRouter now observes the Firebase Authentication state stream and redirects signed-out users away from app routes and signed-in users away from onboarding/auth routes.
- Added a widget test for sign-in and sign-out route transitions.
- Validation: `flutter analyze` passed; `flutter test` passed (2 tests); `flutter build apk --debug` succeeded.