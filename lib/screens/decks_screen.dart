import 'package:flutter/material.dart';
import '../models/deck.dart';
import '../constants/colors.dart';

class DecksScreen extends StatefulWidget {
  const DecksScreen({super.key});

  @override
  State<DecksScreen> createState() => _DecksScreenState();
}

class _DecksScreenState extends State<DecksScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Deck> _filteredDecks = [];
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _filteredDecks = sampleDecks;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDecks = sampleDecks.where((deck) {
        final matchesSearch = deck.name.toLowerCase().contains(query) ||
            deck.description.toLowerCase().contains(query);
        final matchesCategory = _selectedCategory == 'All' || deck.category == _selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _onCategoryChanged(String? category) {
    if (category != null) {
      setState(() {
        _selectedCategory = category;
        _onSearchChanged();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Decks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Implement add new deck
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search decks...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                  ),
                ),
                const SizedBox(height: 16),
                // Category filter
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                  ),
                  items: ['All', 'Beginner', 'Intermediate', 'Advanced']
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: _onCategoryChanged,
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredDecks.isEmpty
                ? Center(
                    child: Text(
                      'No decks found',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredDecks.length,
                    itemBuilder: (context, index) {
                      final deck = _filteredDecks[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          title: Text(deck.name),
                          subtitle: Text(deck.description),
                          trailing: Chip(
                            label: Text(deck.category),
                            backgroundColor: AppColors.primary.withOpacity(0.2),
                          ),
                          onTap: () {
                            // TODO: Navigate to deck details
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}