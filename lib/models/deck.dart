class Deck {
  final String id;
  final String title;
  final String description;
  final int cardCount;
  final double progress;

  const Deck({
    required this.id,
    required this.title,
    required this.description,
    required this.cardCount,
    required this.progress,
  });
}

// Sample decks for testing
final List<Deck> sampleDecks = [
  Deck(
    id: '1',
    title: 'Basic Greetings',
    description: 'Learn common greetings and introductions',
    cardCount: 20,
    progress: 0.25,
  ),
  Deck(
    id: '2',
    title: 'Daily Conversations',
    description: 'Essential phrases for everyday situations',
    cardCount: 30,
    progress: 0.33,
  ),
  Deck(
    id: '3',
    title: 'Business English',
    description: 'Professional vocabulary and expressions',
    cardCount: 40,
    progress: 0.375,
  ),
  Deck(
    id: '4',
    title: 'Advanced Grammar',
    description: 'Complex grammar structures and usage',
    cardCount: 50,
    progress: 0.4,
  ),
]; 