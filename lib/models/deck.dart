class Deck {
  final String id;
  final String name;
  final String description;
  final String category;
  final int totalCards;
  final int learnedCards;

  Deck({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.totalCards,
    this.learnedCards = 0,
  });
}

// Sample decks for testing
final List<Deck> sampleDecks = [
  Deck(
    id: '1',
    name: 'Basic Greetings',
    description: 'Learn common greetings and introductions',
    category: 'Beginner',
    totalCards: 20,
    learnedCards: 5,
  ),
  Deck(
    id: '2',
    name: 'Daily Conversations',
    description: 'Essential phrases for everyday situations',
    category: 'Beginner',
    totalCards: 30,
    learnedCards: 10,
  ),
  Deck(
    id: '3',
    name: 'Business English',
    description: 'Professional vocabulary and expressions',
    category: 'Intermediate',
    totalCards: 40,
    learnedCards: 15,
  ),
  Deck(
    id: '4',
    name: 'Advanced Grammar',
    description: 'Complex grammar structures and usage',
    category: 'Advanced',
    totalCards: 50,
    learnedCards: 20,
  ),
];