# Lab 1: Introduction to Android App Development

Project matches **Lab1HelloAndroid** (Empty Views Activity, Kotlin).

## No space for Android Studio? (phone demo)

GitHub builds the APK in the cloud (no local install).

1. Open **Actions** tab: https://github.com/emrekadioglu/COMP3074/actions  
2. Open the latest **Build Lab1 APK** run (green check).  
3. Under **Artifacts**, download **Lab1HelloAndroid-debug-apk** (small file, ~5–15 MB).  
4. Copy the APK to your **Android phone** (USB, Google Drive, email, etc.).  
5. On the phone: allow install from that app, tap the APK, install **Lab1HelloAndroid**.  
6. Open the app → **Hello Android!** → tap **Click Me** → text becomes **Button clicked!**  
7. Record the screen with the phone’s built-in screen recorder and submit that video.

If the lab requires an **emulator** specifically, tell your instructor you had no disk space for Android Studio and ask if a **phone screen recording** is acceptable.

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

## Lab 2: Counter App

Source is in the `Lab2Counter/` folder. Open that folder in Android Studio, or after a push use **Actions → Build Lab2 APK**.

Behaviour from the lab PDF:

- Output starts at **0**
- **Add** / **Subtract** change the value by **1** by default
- **Step** switches that to **±2**
- **Reset** returns the value to **0** and restores **±1**
- Custom logo, button/background colors, ConstraintLayout on every view

## Key files

| File | Purpose |
|------|---------|
| `app/src/main/java/.../MainActivity.kt` | Button click logic |
| `app/src/main/res/layout/activity_main.xml` | TextView + Button UI |
| `app/src/main/res/values/strings.xml` | Text resources |
| `app/src/main/AndroidManifest.xml` | App configuration |
