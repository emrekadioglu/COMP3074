# COMP3074 – Mobile Application Development

Repository: https://github.com/emrekadioglu/COMP3074

Each lab is a **separate Android Studio project** in its own folder so it is easy to find and grade.

| Lab | Folder | Open this in Android Studio |
|-----|--------|-----------------------------|
| Lab 1 | repo root (`app/`) | the repository root |
| Lab 2 | `Lab2Counter/` | `Lab2Counter` |
| **Lab 3** | **`lab3/`** | **`lab3`** |

---

## Lab 3: Message list (Jetpack Compose)

**Source: [`lab3/`](./lab3)** — this is a complete project, not mixed with Lab 1 or Lab 2.

The app shows a scrollable list of chat messages using a **custom composable** (`MessageCard`): circular profile image with a red border, author name, and a rounded message bubble. Sample data matches the lab screenshot (Joe / Jim).

1. Android Studio → **File → Open** → select the **`lab3`** folder
2. Run on an emulator or phone
3. Or download the APK from **Actions → Build Lab3 APK**

---

## Lab 1: Introduction to Android App Development

Project matches **Lab1HelloAndroid** (Empty Views Activity, Kotlin). Source is in the repository **root** (`app/`).

### No space for Android Studio? (phone demo)

GitHub builds the APK in the cloud (no local install).

1. Open **Actions** tab: https://github.com/emrekadioglu/COMP3074/actions
2. Open the latest **Build Lab1 APK** run (green check).
3. Under **Artifacts**, download **Lab1HelloAndroid-debug-apk** (small file, ~5–15 MB).
4. Copy the APK to your **Android phone** (USB, Google Drive, email, etc.).
5. On the phone: allow install from that app, tap the APK, install **Lab1HelloAndroid**.
6. Open the app → **Hello Android!** → tap **Click Me** → text becomes **Button clicked!**
7. Record the screen with the phone’s built-in screen recorder and submit that video.

## Run Lab 1 in Android Studio (optional)

1. **File → Open** → select the repository root
2. Wait for Gradle sync to finish.
3. **Device Manager** → create/start a Pixel AVD if needed.
4. Click **Run** and test: **Hello Android!** → tap **Click Me** → **Button clicked!**

## Submission (from lab PDF)

- Code is in this GitHub repository.
- Add collaborator: **Przemyslaw Pawluk** (`ppawluk`) on GitHub.
- Submit the **repository link** (URL above).
- Submit a **screen recording** of the app working in the emulator.

---

## Lab 2: Counter App

Source is in the `Lab2Counter/` folder. Open that folder in Android Studio, or after a push use **Actions → Build Lab2 APK**.

Behaviour from the lab PDF:

- Output starts at **0**
- **Add** / **Subtract** change the value by **1** by default
- **Step** switches that to **±2**
- **Reset** returns the value to **0** and restores **±1**
- Custom logo, button/background colors, ConstraintLayout on every view
