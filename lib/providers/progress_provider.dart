import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressProvider extends ChangeNotifier {
  Map<String, List<bool>> _deckProgress = {};
  
  ProgressProvider() {
    _loadProgress();
  }

  double getDeckProgress(String deckId) {
    if (!_deckProgress.containsKey(deckId)) {
      return 0.0;
    }
    final learned = _deckProgress[deckId]!.where((isLearned) => isLearned).length;
    return learned / _deckProgress[deckId]!.length;
  }

  List<bool> getDeckLearnedCards(String deckId) {
    return _deckProgress[deckId] ?? [];
  }

  void initializeDeck(String deckId, int cardCount) {
    if (!_deckProgress.containsKey(deckId)) {
      _deckProgress[deckId] = List.generate(cardCount, (index) => false);
      _saveProgress();
    }
  }

  void markCardAsLearned(String deckId, int cardIndex) {
    if (_deckProgress.containsKey(deckId) && 
        cardIndex < _deckProgress[deckId]!.length) {
      _deckProgress[deckId]![cardIndex] = true;
      _saveProgress();
      notifyListeners();
    }
  }

  void _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final decks = prefs.getStringList('decks') ?? [];
    
    for (var deckId in decks) {
      final progress = prefs.getStringList('deck_$deckId') ?? [];
      _deckProgress[deckId] = progress.map((e) => e == '1').toList();
    }
    notifyListeners();
  }

  void _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('decks', _deckProgress.keys.toList());
    
    for (var entry in _deckProgress.entries) {
      await prefs.setStringList(
        'deck_${entry.key}',
        entry.value.map((e) => e ? '1' : '0').toList(),
      );
    }
  }
} 