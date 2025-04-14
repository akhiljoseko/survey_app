
# Running the Flutter App Locally

This guide will help you set up and run the Flutter app locally on your machine. Please ensure you have Flutter version **3.29.0 or later** installed.

## 🚀 Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.29.0 or later)
- [Dart SDK](https://dart.dev/get-dart) (usually bundled with Flutter)
- IDE (optional but recommended): [VS Code](https://code.visualstudio.com/), [Android Studio](https://developer.android.com/studio)
- Emulator or physical device for testing

## 📦 Check Your Environment

Open a terminal and run:

```bash
flutter --version
```

Ensure the output shows version `3.29.0` or later.

You can also verify your setup using:

```bash
flutter doctor
```

Follow the instructions to fix any missing dependencies or issues.


## 📥 Install Dependencies

```bash
flutter pub get
```

## 🛠️ (Optional) Set Up a Device

To run the app, you’ll need either:

- A physical Android/iOS device with developer mode enabled, or
- An emulator/simulator running

List available devices:

```bash
flutter devices
```

## ▶️ Run the App

```bash
flutter run
```

If prompted, select a device from the list.



## 🧼 Clean the Project (if needed)

Sometimes you may need to clear the build cache:

```bash
flutter clean
flutter pub get
```
---