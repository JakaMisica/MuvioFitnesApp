# Muvio Fitness App

Muvio is a cross-platform Flutter fitness companion built for people who want one place to plan workouts, track recovery, manage nutrition, monitor sleep, and stay accountable with AI-assisted coaching.

The project is designed as a full product prototype rather than a small demo. It includes local-first data storage, workout logging, task alarms, sleep tools, nutrition screens, social features, and AI coach flows.

## Highlights

- Workout planner with exercise templates, sets, rest timers, tempo/TUT tools, drop sets, and progress tracking.
- Body analytics for measurements, muscle fatigue, weight history, grip strength, body fat, and training volume.
- Nutrition tracking with meal sections, food search, barcode scanning, nutrient reporting, and templates.
- Sleep tools with smart alarms, sleep sessions, trends, and foreground/background notification handling.
- AI coaching flows for recommendations, voice/call style coaching, and contextual fitness guidance.
- Social hub for conversations, friend flows, coach selection, and share/import workflows.
- Local persistence with Isar and platform integrations for mobile, desktop, and web targets.

## Tech Stack

- Flutter and Dart
- Bloc/Cubit for state management
- GetIt and Injectable for dependency wiring
- Isar for local data persistence
- Firebase Auth, Firestore, and Storage support
- Google Generative AI integration through build-time configuration
- Android foreground services, local notifications, alarms, audio, sensors, and platform-specific plugins

## Repository Status

This public repository is sanitized for open sharing. It intentionally does not include private Firebase files, signing keys, Google service files, or API keys.

Files intentionally excluded:

- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- Android keystores and `key.properties`
- Any private AI provider keys

## Getting Started

Install Flutter, clone the repository, then fetch dependencies:

```bash
git clone https://github.com/JakaMisica/MuvioFitnesApp.git
cd MuvioFitnesApp
flutter pub get
```

Run the app on a supported target:

```bash
flutter run
```

Build an Android App Bundle:

```bash
flutter build appbundle --release
```

## Firebase Setup

Firebase is optional for local exploration, but required for auth/social/cloud features.

For Android, place your private Firebase config at:

```text
android/app/google-services.json
```

For iOS, place your private Firebase config at:

```text
ios/Runner/GoogleService-Info.plist
```

The Android Google Services Gradle plugin is applied only when `google-services.json` exists, so the public repository can still build without publishing private Firebase configuration.

## Build-Time Configuration

Muvio reads sensitive values through Dart defines instead of hardcoded source values.

Example Android/desktop run:

```bash
flutter run \
  --dart-define=GEMINI_API_KEY_1=your_key_here \
  --dart-define=FIREBASE_API_KEY=your_firebase_api_key \
  --dart-define=FIREBASE_APP_ID=your_firebase_app_id \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID=your_sender_id \
  --dart-define=FIREBASE_PROJECT_ID=your_project_id \
  --dart-define=FIREBASE_STORAGE_BUCKET=your_bucket
```

You can also keep these values in a private JSON file and run with:

```bash
flutter run --dart-define-from-file=config/private.env.json
```

See [docs/configuration.md](docs/configuration.md) for a complete example.

## Project Structure

```text
lib/
  core/          Shared services, theme, constants, and utilities
  data/          Isar models, generated adapters, and repositories
  logic/         Cubits, states, and domain calculators
  presentation/  Screens, dialogs, widgets, and navigation
assets/
  audio/         Alarms and UI sounds
  images/        Muscle group assets
  models/        3D and local model assets
android/ ios/    Mobile platform projects
windows/ linux/ macos/ desktop platform projects
web/             Flutter web shell
```

## Security Notes

Never commit API keys, Firebase configs, keystores, signing passwords, or generated release artifacts. Use `.gitignore`, Dart defines, local config files, and GitHub secrets for private values.

If a secret is accidentally committed, rotate/revoke it immediately. Removing it from a later commit is not enough if it already reached public history.

## Development Notes

The repository contains a vendored `share_plus` override under `plugins/share_plus`. Analyzer output may include noise from plugin example projects and older generated files. The Android release bundle has been verified after the public rename.

## License

No license has been selected yet. Until a license is added, all rights are reserved by the repository owner.
