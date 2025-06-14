import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

class AppRoutes {
  static const String loading = '/';
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
    loading: (context) => const LoadingScreen(),
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    home: (context) => const HomeScreen(),
    profile: (context) => const ProfileScreen(),
  };
} 