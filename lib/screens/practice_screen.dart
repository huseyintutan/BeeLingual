import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:beelingual/models/flashcard.dart';
import 'package:beelingual/constants/colors.dart';
import 'package:beelingual/providers/progress_provider.dart';
import 'package:beelingual/screens/test_screen.dart';

class PracticeScreen extends StatefulWidget {
  final String deckId;
  final List<Flashcard> flashcards;

  const PracticeScreen({
    super.key,
    required this.deckId,
    required this.flashcards,
  });

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  bool isShowingTranslation = false;
  int _currentIndex = 0;
  final SwiperController _swiperController = SwiperController();

  @override
  void initState() {
    super.initState();
    // Initialize deck in the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProgressProvider>().initializeDeck(
        widget.deckId,
        widget.flashcards.length,
      );
    });
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  void _markAsLearned() {
    context.read<ProgressProvider>().markCardAsLearned(
      widget.deckId,
      _currentIndex,
    );
  }

  void _nextCard() {
    if (_currentIndex < widget.flashcards.length - 1) {
      _swiperController.next();
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      _swiperController.previous();
    }
  }

  void _startTest() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TestScreen(
          flashcards: widget.flashcards,
          category: widget.deckId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressProvider>(
      builder: (context, progressProvider, child) {
        final learnedCards = progressProvider.getDeckLearnedCards(widget.deckId);
        final allCardsLearned = learnedCards.isNotEmpty && 
                               learnedCards.every((learned) => learned);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Practice'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Column(
            children: [
              // Progress indicator
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progressProvider.getDeckProgress(widget.deckId),
                        backgroundColor: AppColors.primary.withOpacity(0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${learnedCards.where((learned) => learned).length}/${learnedCards.length}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Flashcard swiper
              Expanded(
                child: Stack(
                  children: [
                    Swiper(
                      controller: _swiperController,
                      itemBuilder: (context, index) {
                        return _buildFlashcard(widget.flashcards[index]);
                      },
                      itemCount: widget.flashcards.length,
                      viewportFraction: 0.85,
                      scale: 0.9,
                      onIndexChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                          isShowingTranslation = false;
                        });
                      },
                    ),
                    // Navigation buttons
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              color: _currentIndex > 0 ? AppColors.primary : Colors.transparent,
                              size: 40,
                            ),
                            onPressed: _currentIndex > 0 ? _previousCard : null,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.chevron_right,
                              color: _currentIndex < widget.flashcards.length - 1 ? AppColors.primary : Colors.transparent,
                              size: 40,
                            ),
                            onPressed: _currentIndex < widget.flashcards.length - 1 ? _nextCard : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom controls
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(
                          Icons.volume_up,
                          AppColors.primary,
                          onTap: () {
                            // TODO: Implement text-to-speech
                          },
                        ),
                        _buildActionButton(
                          isShowingTranslation ? Icons.visibility_off : Icons.visibility,
                          AppColors.primary,
                          onTap: () {
                            setState(() {
                              isShowingTranslation = !isShowingTranslation;
                            });
                          },
                        ),
                        _buildActionButton(
                          learnedCards.isNotEmpty && learnedCards[_currentIndex]
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          learnedCards.isNotEmpty && learnedCards[_currentIndex]
                              ? Colors.green
                              : AppColors.primary,
                          onTap: _markAsLearned,
                        ),
                      ],
                    ),
                    if (allCardsLearned) ...[
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _startTest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        child: const Text('Start Test'),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFlashcard(Flashcard card) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isShowingTranslation = !isShowingTranslation;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        card.question,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      if (isShowingTranslation) ...[
                        const SizedBox(height: 20),
                        Text(
                          card.answer,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.primary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
} 