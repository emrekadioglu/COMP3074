# Lab 3 – Message list (Jetpack Compose)

Custom Compose UI that shows a scrollable chat list.

Open **this folder** in Android Studio: `lab3/`

## What it does

- `Message` data class holds author + body
- `MessageCard` is a custom composable (circular avatar, red border, name, rounded bubble)
- `Conversation` uses `LazyColumn` to list many messages
- Sample messages match the lab screenshot (Joe / Jim)

## Run

1. Android Studio → **File → Open** → select the `lab3` folder (not the repo root)
2. Sync Gradle, then **Run** on an emulator or phone

GitHub Actions also builds an APK: **Actions → Build Lab3 APK**
