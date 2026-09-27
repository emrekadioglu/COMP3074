# Lab 1: Introduction to Android App Development

Project matches **Lab1HelloAndroid** (Empty Views Activity, Kotlin).

## Low storage? (no Android Studio on your PC)

GitHub builds the app in the cloud — you only download a small **APK** (~5–15 MB).

1. Open **Actions** on the repo → workflow **Build Lab1 APK** → latest run → download artifact **Lab1HelloAndroid-debug-apk**.
2. **Android phone:** copy `app-debug.apk` to the phone → install (allow install from Files/Drive if asked) → open **Lab1HelloAndroid** → record screen: **Hello Android!** → **Click Me** → **Button clicked!**
3. If the lab requires an **emulator** specifically, use a campus PC, a friend’s machine with Android Studio, or ask the instructor — explain you have no disk space for the SDK.

## Run in Android Studio (optional)

1. **File → Open** → select `D:\COMP3074\Lab1HelloAndroid`
2. Wait for Gradle sync to finish.
3. **Device Manager** → create/start a Pixel AVD if needed.
4. Click **Run** and test: **Hello Android!** → tap **Click Me** → **Button clicked!**

## Repository

https://github.com/emrekadioglu/COMP3074

## Submission (from lab PDF)

- Code is in this GitHub repository.
- Add collaborator: **Przemyslaw Pawluk** (`ppawluk`) on GitHub.
- Submit the **repository link** (URL above).
- Submit a **screen recording** of the app working in the emulator.

## Key files

| File | Purpose |
|------|---------|
| `app/src/main/java/.../MainActivity.kt` | Button click logic |
| `app/src/main/res/layout/activity_main.xml` | TextView + Button UI |
| `app/src/main/res/values/strings.xml` | Text resources |
| `app/src/main/AndroidManifest.xml` | App configuration |
