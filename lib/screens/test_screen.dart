import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../constants/colors.dart';
import 'dart:math';

class TestScreen extends StatefulWidget {
  final List<Flashcard> flashcards;
  final String category;

  const TestScreen({
    super.key,
    required this.flashcards,
    required this.category,
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late List<Flashcard> _testCards;
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  bool _hasAnswered = false;
  int? _selectedAnswerIndex;
  late List<String> _currentOptions;

  @override
  void initState() {
    super.initState();
    // Shuffle the flashcards and take first 10
    _testCards = List.from(widget.flashcards)..shuffle();
    if (_testCards.length > 10) {
      _testCards = _testCards.sublist(0, 10);
    }
    _generateOptions();
  }

  void _generateOptions() {
    final correctAnswer = _testCards[_currentQuestionIndex].answer;
    final allAnswers = widget.flashcards.map((card) => card.answer).toList();
    allAnswers.remove(correctAnswer);
    allAnswers.shuffle();

    // Take 3 wrong answers
    final wrongAnswers = allAnswers.take(3).toList();
    _currentOptions = [...wrongAnswers, correctAnswer];
    _currentOptions.shuffle();
  }

  void _checkAnswer(int selectedIndex) {
    if (_hasAnswered) return;

    setState(() {
      _hasAnswered = true;
      _selectedAnswerIndex = selectedIndex;
      
      if (_currentOptions[selectedIndex] == _testCards[_currentQuestionIndex].answer) {
        _correctAnswers++;
      }
    });

    // Wait for 1.5 seconds before moving to next question
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (_currentQuestionIndex < _testCards.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _hasAnswered = false;
          _selectedAnswerIndex = null;
          _generateOptions();
        });
      }
    });
  }

  Color _getOptionColor(int index) {
    if (!_hasAnswered) return Colors.white;

    if (_currentOptions[index] == _testCards[_currentQuestionIndex].answer) {
      return Colors.green.withOpacity(0.2);
    }
    
    if (index == _selectedAnswerIndex) {
      return Colors.red.withOpacity(0.2);
    }

    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final isLastQuestion = _currentQuestionIndex == _testCards.length - 1;
    final progress = (_currentQuestionIndex + 1) / _testCards.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.primary.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_testCards.length}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            
            // Question card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      _testCards[_currentQuestionIndex].question,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'What does this mean?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Options
            ...List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: InkWell(
                  onTap: () => _checkAnswer(index),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: _getOptionColor(index),
                      border: Border.all(
                        color: _hasAnswered && _currentOptions[index] == _testCards[_currentQuestionIndex].answer
                            ? Colors.green
                            : AppColors.primary.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _currentOptions[index],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              );
            }),

            if (_hasAnswered && isLastQuestion) ...[
              const SizedBox(height: 24),
              Text(
                'Test Complete!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'You got $_correctAnswers out of ${_testCards.length} correct!',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Back to Practice'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}