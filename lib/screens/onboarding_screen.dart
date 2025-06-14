import 'package:flutter/material.dart';
import 'package:beelingual/constants/colors.dart';
import 'package:beelingual/screens/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Welcome to BeeLingual',
      'description': 'Start your language learning journey with our interactive flashcards.',
      'icon': Icons.language,
    },
    {
      'title': 'Learn with Flashcards',
      'description': 'Create and study flashcard decks to memorize vocabulary effectively.',
      'icon': Icons.school,
    },
    {
      'title': 'Track Your Progress',
      'description': 'Monitor your learning progress and stay motivated.',
      'icon': Icons.trending_up,
    },
  ];

  @override
  void initState() {
    super.initState();
    debugPrint('Initializing OnboardingScreen...');
  }

  @override
  void dispose() {
    debugPrint('Disposing OnboardingScreen...');
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    debugPrint('Page changed to: $_currentPage');
  }

  void _navigateToHome() {
    debugPrint('Navigating to HomeScreen...');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building OnboardingScreen...');
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            page['icon'] as IconData,
                            size: 100,
                            color: AppColors.primary,
                          ),
                          const SizedBox(height: 40),
                          Text(
                            page['title'] as String,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            page['description'] as String,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: _pages.length,
                      effect: WormEffect(
                        dotColor: AppColors.grey.withOpacity(0.3),
                        activeDotColor: AppColors.primary,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 8,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentPage > 0)
                          TextButton(
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Text(
                              'Back',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                              ),
                            ),
                          )
                        else
                          const SizedBox(width: 60),
                        ElevatedButton(
                          onPressed: _currentPage == _pages.length - 1
                              ? _navigateToHome
                              : () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size(120, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 