import 'package:activity_8/screens/mtg/mtg_search_screen.dart';
import 'package:activity_8/screens/pokemon/card_list_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.style), text: 'MTG'),
            Tab(icon: Icon(Icons.catching_pokemon), text: 'Pokémon'),
          ],
        ),
        body: const TabBarView(children: [MtgSearchScreen(), PokeListScreen()]),
      ),
    );
  }
}
