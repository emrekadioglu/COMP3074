# GPS Location App (Flutter)

Shows the device's current **latitude and longitude** from the GPS.

## Features
- Reads location from GPS (`LocationAccuracy.best`) using the `geolocator` package
- Android permissions declared in the manifest (`ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`) and requested at runtime
- iOS permission string (`NSLocationWhenInUseUsageDescription`)
- Handles every case: GPS off, permission denied, permanently denied, timeout
- One-tap "Get Location", optional live updates, copy-to-clipboard
- Also shows accuracy, altitude, and timestamp

## Setup
1. Install Flutter: https://docs.flutter.dev/get-started/install
2. Create the project shell, then copy these files in:
   ```
   flutter create gps_location_app
   cd gps_location_app
   ```
   - Replace `pubspec.yaml` and `lib/main.dart` with the ones here
   - Replace `android/app/src/main/AndroidManifest.xml` with `android_snippet/AndroidManifest.xml`
   - (iOS only) add `ios_snippet/Info.plist.add.xml` content into `ios/Runner/Info.plist`
3. Run:
   ```
   flutter pub get
   flutter run
   ```
   Use a real phone (best GPS) or an emulator with a mock location
   (Android Studio emulator: ... > Location > set a point > Send).

## How it works
`_ensureReady()` checks that location services are on, then checks/requests
runtime permission. Only then does it call `Geolocator.getCurrentPosition`.
