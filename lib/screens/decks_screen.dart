import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beelingual/constants/colors.dart';
import 'package:beelingual/models/deck.dart';
import 'package:beelingual/models/flashcard.dart';
import 'package:beelingual/providers/progress_provider.dart';
import 'package:beelingual/screens/practice_screen.dart';

class DecksScreen extends StatefulWidget {
  const DecksScreen({super.key});

  @override
  State<DecksScreen> createState() => _DecksScreenState();
}

class _DecksScreenState extends State<DecksScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  // Sample decks data
  final List<Deck> _decks = [
    Deck(
      id: '1',
      title: 'Havacılık Terimleri',
      description: 'Aviation terms in Turkish and English',
      cardCount: aviationFlashcards.length,
      progress: 0.0,
    ),
    Deck(
      id: '2',
      title: 'Medikal Terimler',
      description: 'Medical terms in Turkish and English',
      cardCount: medicalFlashcards.length,
      progress: 0.0,
    ),
  ];

  List<Deck> get _filteredDecks {
    if (_searchQuery.isEmpty) {
      return _decks;
    }
    return _decks.where((deck) {
      final title = deck.title.toLowerCase();
      final description = deck.description.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return title.contains(query) || description.contains(query);
    }).toList();
  }

  void _navigateToPractice(BuildContext context, String deckId) {
    final flashcards = deckId == '1' ? aviationFlashcards : medicalFlashcards;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PracticeScreen(
          deckId: deckId,
          flashcards: flashcards,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressProvider>(
      builder: (context, progressProvider, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search decks...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: _filteredDecks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No decks found',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredDecks.length,
                      itemBuilder: (context, index) {
                        final deck = _filteredDecks[index];
                        final progress = progressProvider.getDeckProgress(deck.id);
                        
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            title: Text(
                              deck.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(deck.description),
                                const SizedBox(height: 8),
                                LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: Colors.grey[200],
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${(progress * 100).toInt()}% Complete',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            trailing: Text(
                              '${deck.cardCount} Cards',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            onTap: () => _navigateToPractice(context, deck.id),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
} 