# Contributing

Thanks for taking a look at Muvio. This repository is a product-style Flutter app, so changes should preserve build stability and avoid leaking private configuration.

## Local Setup

```bash
flutter pub get
flutter run
```

Optional Firebase and AI features require local configuration. See [docs/configuration.md](docs/configuration.md).

## Before Opening a Pull Request

Run:

```bash
flutter pub get
flutter build appbundle --release
```

If you touch generated Isar models, regenerate and commit the matching generated files.

## Code Style

- Prefer existing Bloc/Cubit and repository patterns.
- Keep platform-specific code behind service classes when possible.
- Do not commit secrets, keystores, Firebase config files, build outputs, or local environment files.
- Keep public documentation accurate about what works without private configuration.

## Security

If you discover a secret in history or source, rotate it before continuing. Do not open a public issue containing the secret value.
