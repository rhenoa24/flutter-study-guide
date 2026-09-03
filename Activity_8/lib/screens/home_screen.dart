import 'package:activity_8/screens/mtg/mtg_search_screen.dart';
import 'package:activity_8/screens/pokemon/card_list_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity 8')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MtgSearchScreen()),
              ),
              child: const Text('MTG'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PokeListScreen()),
              ),
              child: const Text('Pokémon'),
            ),
          ],
        ),
      ),
    );
  }
}
