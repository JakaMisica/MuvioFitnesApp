# Flutter Window Sidecar / SDK 34+ R8 Fixes
-dontwarn androidx.window.extensions.**
-dontwarn androidx.window.sidecar.**

# Common Flutter Firebase / AGP 8 Fixes
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Keep our models for JSON/Isar if needed
-keep class com.muvio.muvio.data.models.** { *; }
