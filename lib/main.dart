import 'package:flutter/material.dart';
import 'package:beelingual_flashcards/screens/home_screen.dart';
import 'package:beelingual_flashcards/constants/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeeLingual',
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}
