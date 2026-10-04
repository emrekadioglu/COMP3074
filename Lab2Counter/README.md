# Lab 2: Counter App

Project matches **Lab2Counter** (Empty Views Activity, Kotlin).

Built from `lab2 (1).pdf`:

| Requirement | How it is implemented |
|-------------|------------------------|
| App logo | Vector logo (`ic_app_logo`) on screen + launcher icon |
| Output label, initial 0 | `textViewOutput` starts at **0** |
| Add | Increases the value by the current step (default **1**) |
| Subtract | Decreases the value by the current step (default **1**) |
| Reset | Sets the value back to **0** and restores default step **1** |
| Step | Changes Add/Subtract from **±1** to **±2** |
| Button and background colors | Distinct tints + light blue screen background |
| Constraints | All views use ConstraintLayout constraints |

## Demo on phone (no Android Studio)

GitHub can build the APK in the cloud after this project is pushed.

1. Open **Actions**: https://github.com/emrekadioglu/COMP3074/actions
2. Open the latest **Build Lab2 APK** run (green check).
3. Under **Artifacts**, download **Lab2Counter-debug-apk**.
4. Install it on your Android phone.
5. Record: logo visible → Add/Subtract by 1 → Step → Add/Subtract by 2 → Reset returns to 0 and ±1.

## Run in Android Studio

1. **File → Open** → select `D:\COMP3074\Lab2Counter`
2. Wait for Gradle sync.
3. Click **Run**.

## Repository

https://github.com/emrekadioglu/COMP3074
