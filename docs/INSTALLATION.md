# Installation and setup guide

## 1. Prerequisites

- Flutter SDK 3.13 or later
- Android Studio or VS Code with Flutter extension
- A Firebase project created in the Firebase Console
- Android and iOS platform setup tools as needed for the target device

## 2. Clone the project

```bash
git clone <repository-url>
cd lifexp_app
```

## 3. Install dependencies

```bash
flutter pub get
```

## 4. Firebase configuration

Use the FlutterFire CLI to generate the required Firebase project configuration files.

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

After configuration, add the generated platform files:

- Android: `android/app/google-services.json`
- iOS: `ios/Runner/GoogleService-Info.plist`

> Do not commit secrets or platform configuration files if the repository is public. Keep them in a secure environment or use a private setup workflow.

## 5. Run the app

```bash
flutter run
```

## 6. Build an APK

```bash
flutter build apk --release
```

## 7. Troubleshooting

- If Flutter commands are not recognized, restart the terminal after SDK installation.
- If Firebase setup fails, re-run `flutterfire configure` from the project root.
- If the app shows a startup shell without full Firebase features, the app is still in the foundation phase and Firebase integration will be completed in the upcoming phases.
