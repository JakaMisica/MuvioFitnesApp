# Architecture Overview

Muvio follows a layered Flutter structure that keeps UI, state, persistence, and services separated enough for the app to grow.

## Layers

```text
presentation -> logic -> data -> platform/services
```

## Presentation

`lib/presentation` contains screens, dialogs, overlays, navigation, and reusable widgets. This layer should focus on rendering state and collecting user input.

Important areas:

- `screens/workout_window` for training workflows.
- `screens/main_window` for dashboard, body metrics, and progress.
- `screens/diet` for nutrition tracking.
- `screens/sleep` for sleep and alarm experiences.
- `screens/social` for chat, sharing, and accountability features.

## Logic

`lib/logic` contains Cubits and calculators. Cubits coordinate repositories and services, then expose state to the UI.

Examples:

- `WorkoutCubit` manages workout days, sets, timers, and workout progression.
- `SleepCubit` coordinates sleep sessions and alarm behavior.
- `SocialCubit` manages conversations and social interactions.
- `EvolutionCubit` tracks body metrics and progression.

## Data

`lib/data` contains Isar models and repositories. Repositories wrap local persistence and provide a cleaner API to Cubits.

Generated Isar files are included so the project can be inspected and built without immediately regenerating code.

## Core Services

`lib/core/services` contains platform and product services:

- Notifications and foreground tasks.
- AI response orchestration.
- Sleep analysis.
- Step tracking.
- Voice/body services.
- Referral and analytics helpers.

## Public Repository Constraints

The public repo avoids committing private runtime configuration. Any feature that depends on Firebase or external AI providers needs local configuration before it is fully functional.
