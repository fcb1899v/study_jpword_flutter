# JPWord - Interactive Japanese Kana & Word Learning App

<div align="center">
  <img src="assets/icon/icon.png" alt="JPWord Icon" width="120" height="120">
  <br>
  <strong>Learn Japanese Hiragana, Katakana, and Words Easily</strong>
  <br>
  <strong>Interactive learning with text-to-speech and visual aids</strong>
</div>

## 📱 Application Overview

JPWord is a Flutter-based educational app for Android & iOS that helps users learn Japanese Hiragana, Katakana, and vocabulary through interactive exercises.
It provides an engaging learning experience with text-to-speech, visual word images, and a comprehensive kana/word library.

### 🎯 Key Features

- **Comprehensive Kana Coverage**: All basic Hiragana and Katakana characters
- **Word Learning**: 169+ Japanese words with images and readings
- **Text-to-Speech Integration**: High-quality Japanese voice pronunciation
- **Cross-platform Support**: Android & iOS compatibility
- **Interactive Learning**: Tap to hear sounds and practice pronunciation
- **Visual Learning Aids**: Word images with clear typography
- **Firebase Analytics**: Track learning progress and app usage
- **AdMob Integration**: Banner ads for monetization
- **Responsive Design**: Adapts to different screen sizes
- **App Tracking Transparency**: iOS privacy compliance

## 🚀 Technology Stack

### Frameworks & Libraries
- **Flutter**: 3.3.0+
- **Dart**: 2.18.0+
- **Firebase**: Analytics
- **Google Mobile Ads**: Banner advertisement display

### Core Features
- **Text-to-Speech**: flutter_tts
- **State Management**: hooks_riverpod, flutter_hooks
- **Environment Variables**: flutter_dotenv
- **App Tracking Transparency**: app_tracking_transparency
- **App Icons**: flutter_launcher_icons
- **Splash Screen**: flutter_native_splash

## 📋 Prerequisites

- Flutter 3.47.0+ (required by Android Gradle Plugin 9: earlier versions
  force the Kotlin Gradle Plugin onto modules that AGP 9 compiles itself)
- Dart 3.13.0+
- Android Studio / Xcode
- Firebase (Analytics)

## 🛠️ Setup

### 1. Clone the Repository
```bash
git clone https://github.com/fcb1899v/study_jpword_flutter.git
cd study_jpword_flutter
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configuration Files Setup

**Environment variables.** Copy `assets/.env_example` to `assets/.env` and fill
in the values. The template lists every key with what it is for, and is the one
place that list is maintained. `pubspec.yaml` declares `assets/.env`, so the
file has to exist or the build fails. Debug builds use Google's demo ad units
and need no real ids, and the demo unit for an inline adaptive request is not
the same id as the fixed-size one.

**Android signing, release only.** Copy `android/key.properties.example` to
`android/key.properties` and fill it in. Nothing in it ships inside the app, and
the two passwords are real secrets: together with the keystore they let anyone
publish an update Play accepts as coming from you. Keep the keystore outside the
repository and back both up. A release built without this file falls back to the
debug signing config, which produces an artifact Play rejects.

### 4. Firebase Configuration
1. Create a Firebase project
2. Place `google-services.json` (Android) in `android/app/`
3. Place `GoogleService-Info.plist` (iOS) in `ios/Runner/`
4. These files are tracked here. The Gradle plugin fails the Android build
   without the json, and the Xcode project lists the plist in its Resources
   phase, so excluding them only broke fresh clones. They carry the same
   identifiers as `lib/firebase_options.dart`, which ship inside the app.
   Real secrets stay out: the keystore and the environment file

### 5. Run the Application
```bash
# Android
flutter run

# iOS (Swift Package Manager: there is no Podfile to install)
flutter run
```

## 🎮 Application Structure

```
lib/
├── main.dart                    # Application entry point
├── homepage.dart                # Main kana/word learning page
├── listpage.dart                # Kana/word selection grid
├── tts_manager.dart             # Text-to-speech management
├── admob_banner.dart            # Banner advertisement management
├── constant.dart                # Constant definitions
├── extension.dart               # Extension functions
└── firebase_options.dart        # Firebase configuration

assets/
├── image/                       # Learning images for words
│   ├── sakura.png               # Word images for each vocabulary
│   ├── neko.png
│   ├── inu.png
│   └── ...                      # 169+ word images total
├── fonts/                       # Font files
│   └── JPWordFont.ttf           # Custom font
├── icon/                        # App icons
│   ├── icon.png
│   ├── appIcon.png
│   └── splash.png
└── .env                         # Environment variables
```

## 🎨 Learning Content

### Hiragana & Katakana
- All 46 basic Hiragana
- All 46 basic Katakana
- Voiced, semi-voiced, and combination kana

### Vocabulary Words
- 169+ common Japanese words
- Each word includes: image, kana, and pronunciation

## 📱 Supported Platforms

- **Android**: API 23+ (Android 6.0+)
- **iOS**: iOS 14.0+
- **Web**: Coming soon

## 🔧 Development

### Code Analysis
```bash
flutter analyze
```

### Run Tests

There are none. The `flutter create` counter test was removed on 2026-09-02
because it asserted on a widget this app does not have and could only ever fail,
which made a red `flutter test` indistinguishable from a real failure.

`flutter analyze` is the check that runs clean and is expected to stay that way.

```bash
flutter analyze   # expected: No issues found!
```

### Build
```bash
# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# iOS
flutter build ios
```

### Generate App Icons
```bash
flutter pub run flutter_launcher_icons:main
```

### Generate Splash Screen
```bash
flutter pub run flutter_native_splash:create
```

## 🎯 Learning Features

### Interactive Learning
- **Tap to Hear**: Tap any kana or word to hear pronunciation
- **Visual Aids**: Each word has an associated image
- **Progress Tracking**: Firebase Analytics tracks learning progress

### Text-to-Speech Features
- **High-Quality Voices**: Platform-optimized Japanese voice
- **Clear Pronunciation**: Optimized speech rate for learning
- **Ready for Expansion**: Easily add more words or features

### User Experience
- **Responsive Design**: Adapts to different screen sizes
- **Intuitive Navigation**: Simple grid-based selection
- **Accessibility**: Large text and clear contrast

## 🔒 Security

This project includes security measures to protect sensitive information:
- Environment variables for API keys
- Firebase configuration files are excluded from version control
- Ad unit IDs are stored in environment files
- Keystore files are properly excluded

## 📄 License

This project is licensed under the MIT License.

## 🤝 Contributing

Pull requests and issue reports are welcome. Please ensure your code follows the existing style and includes appropriate tests.

## 📞 Support

If you have any problems or questions, please create an issue on GitHub.

## 🚀 Getting Started

For new developers:
1. Follow the setup instructions above
2. Check the application structure
3. Review the kana and vocabulary content organization
4. Start with the main.dart file to understand the app flow
5. Explore the tts_manager.dart for text-to-speech functionality

---

<div align="center">
  <strong>JPWord</strong> - Making Japanese learning fun and effective!
</div>

## Licenses & Credits

This app uses the following open-source libraries:

- Flutter (BSD 3-Clause License)
- firebase_core, firebase_analytics (Apache License 2.0)
- google_mobile_ads (Apache License 2.0)
- flutter_dotenv (MIT License)
- flutter_tts (BSD 3-Clause License)
- hooks_riverpod, flutter_hooks (MIT License)
- cupertino_icons (MIT License)
- flutter_launcher_icons (MIT License)
- flutter_native_splash (MIT License)
- app_tracking_transparency (MIT License)

For details of each license, please refer to [pub.dev](https://pub.dev/) or the LICENSE file in each repository.

## 📊 Analytics & Privacy

- **Firebase Analytics**: Tracks app usage and learning progress
- **App Tracking Transparency**: iOS privacy compliance
- **AdMob**: Banner ads for monetization

## 🎓 Educational Value

JPWord is designed to help:
- **Japanese Learners**: Master Hiragana, Katakana, and basic vocabulary
- **Early Learners**: Learn basic Japanese sounds and words
- **ESL/Foreign Students**: Practice Japanese pronunciation
- **Special Education**: Visual and auditory learning support
- **Parents & Teachers**: Educational tool for Japanese instruction

---

<div align="center">
  <strong>JPWord</strong> - Empowering learners through interactive Japanese education!
</div>
