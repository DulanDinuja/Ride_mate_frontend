# RideMate - Setup & Run Instructions

## Prerequisites
1. Install Flutter SDK: https://docs.flutter.dev/get-started/install/windows
2. Install Android Studio or VS Code with Flutter extension
3. Install Git

## Setup Steps

### 1. Verify Flutter Installation
```bash
flutter doctor
```

### 2. Install Dependencies
```bash
cd "d:\OneDrive - Group of LOLC\Desktop\Ridemate"
flutter pub get
```

### 3. Configure Backend API (Optional for now)
Edit `lib/core/constants/app_constants.dart`:
```dart
static const String baseUrl = 'http://your-api-url.com/v1';
```

### 4. Run the App

**Option A: Using Command Line**
```bash
# Connect Android device or start emulator
flutter devices

# Run the app
flutter run
```

**Option B: Using VS Code**
1. Open folder in VS Code
2. Press F5 or click "Run > Start Debugging"
3. Select device from bottom right

**Option C: Using Android Studio**
1. Open project in Android Studio
2. Wait for Gradle sync
3. Click Run button (green play icon)

## Quick Start (No Backend)
The app will run with mock data. All screens are functional for UI testing.

## Troubleshooting

**Error: Flutter not found**
- Add Flutter to PATH: `C:\flutter\bin`

**Error: No devices found**
- Start Android emulator from Android Studio
- Or connect physical device with USB debugging enabled

**Error: Gradle build failed**
- Run: `flutter clean && flutter pub get`

**Error: Dependencies not found**
- Run: `flutter pub get`

## Project Structure
```
lib/
├── main.dart              # App entry point
├── core/                  # Constants & themes
├── data/                  # Models & repositories
└── presentation/          # UI screens & providers
```

## Test Run (Fastest Method)
```bash
flutter run -d chrome
```
This runs the app in Chrome browser (no Android setup needed).
