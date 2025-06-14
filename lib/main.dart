import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/theme_provider.dart';
import 'constants/theme.dart';
import 'screens/splash_screen.dart';
import 'providers/progress_provider.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    debugPrint('Flutter binding initialized');
    
    debugPrint('Getting SharedPreferences instance...');
    final prefs = await SharedPreferences.getInstance();
    debugPrint('SharedPreferences initialized successfully');
    
    debugPrint('Creating ThemeProvider...');
    final themeProvider = ThemeProvider();
    debugPrint('Initializing ThemeProvider with preferences...');
    await themeProvider.initializeTheme(prefs);
    debugPrint('ThemeProvider initialized successfully');
    
    debugPrint('Creating ProgressProvider...');
    final progressProvider = ProgressProvider();
    debugPrint('ProgressProvider created successfully');
    
    debugPrint('Starting app with providers...');
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: themeProvider),
          ChangeNotifierProvider.value(value: progressProvider),
        ],
        child: Builder(
          builder: (context) {
            debugPrint('Building root widget...');
            return const BeeLingualApp();
          },
        ),
      ),
    );
    debugPrint('App started successfully');
  } catch (e, stackTrace) {
    debugPrint('Error starting app: $e');
    debugPrint('Stack trace: $stackTrace');
    rethrow;
  }
}

class BeeLingualApp extends StatelessWidget {
  const BeeLingualApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Building BeeLingualApp...');
    try {
      return MaterialApp(
        title: 'BeeLingual',
        debugShowCheckedModeBanner: false,
        theme: context.watch<ThemeProvider>().isDarkMode 
          ? AppTheme.darkTheme 
          : AppTheme.lightTheme,
        home: const SplashScreen(),
      );
    } catch (e, stackTrace) {
      debugPrint('Error building BeeLingualApp: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }
} 