# BeeLingual - Language Learning Flashcards App

BeeLingual is a modern Flutter application designed to help users learn languages through interactive flashcards. The app features a clean, intuitive interface and supports both light and dark themes.

## Features

- **Interactive Flashcards**: Create and study custom flashcard decks
- **Progress Tracking**: Monitor your learning progress
- **Theme Support**: Switch between light and dark themes
- **User-Friendly Interface**: Smooth animations and intuitive navigation
- **Responsive Design**: Works on both mobile and web platforms

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/BeeLingual.git
```

2. Navigate to the project directory:
```bash
cd BeeLingual
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── constants/
│   ├── colors.dart
│   └── theme.dart
├── models/
│   ├── deck.dart
│   └── flashcard.dart
├── providers/
│   ├── theme_provider.dart
│   └── progress_provider.dart
├── screens/
│   ├── splash_screen.dart
│   ├── onboarding_screen.dart
│   ├── home_screen.dart
│   ├── decks_screen.dart
│   ├── practice_screen.dart
│   └── profile_screen.dart
└── main.dart
```

## Recent Updates

- Added splash screen with animations
- Implemented onboarding flow
- Added theme switching functionality
- Created basic flashcard deck management
- Improved navigation and user experience

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details. 