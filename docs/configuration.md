# Configuration Guide

This project is public-safe by default. Private service credentials are loaded from local files or build-time values and should never be committed.

## Firebase

Firebase is used for authentication, social features, Firestore, and storage.

Required private files:

```text
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
```

These files are ignored by Git. Add them locally from your own Firebase project settings.

The Android build applies `com.google.gms.google-services` only when `android/app/google-services.json` exists. This lets contributors build the public project without having access to the private Firebase project.

## AI Provider Keys

AI keys are passed through Dart defines. Do not place real keys in source files.

Supported defines:

```text
GEMINI_API_KEY_1
GEMINI_API_KEY_2
GEMINI_API_KEY_3
GEMINI_API_KEY_4
GROQ_API_KEY_1
GROQ_API_KEY_2
GROQ_API_KEY_3
GROQ_API_KEY_4
GROQ_API_KEY_5
NOVITA_API_KEY
FIREBASE_API_KEY
FIREBASE_APP_ID
FIREBASE_MESSAGING_SENDER_ID
FIREBASE_PROJECT_ID
FIREBASE_STORAGE_BUCKET
```

## Private Config File

Create a local file that is not committed, for example:

```text
config/private.env.json
```

Example shape:

```json
{
  "GEMINI_API_KEY_1": "replace_me",
  "FIREBASE_API_KEY": "replace_me",
  "FIREBASE_APP_ID": "replace_me",
  "FIREBASE_MESSAGING_SENDER_ID": "replace_me",
  "FIREBASE_PROJECT_ID": "replace_me",
  "FIREBASE_STORAGE_BUCKET": "replace_me"
}
```

Run with:

```bash
flutter run --dart-define-from-file=config/private.env.json
```

Build with:

```bash
flutter build appbundle --release --dart-define-from-file=config/private.env.json
```

## Release Signing

Android release signing uses `android/key.properties` when present. Keep this file and keystores private.

Expected local-only shape:

```properties
storePassword=replace_me
keyPassword=replace_me
keyAlias=replace_me
storeFile=replace_me.jks
```

## Secret Hygiene

Before pushing public changes, scan for common key patterns:

```bash
rg -n --hidden --glob '!build/**' --glob '!.git/**' --glob '!.dart_tool/**' "API_KEY|PRIVATE KEY|TOKEN|SECRET"
```

If a key is exposed, revoke it immediately and create a new one.
