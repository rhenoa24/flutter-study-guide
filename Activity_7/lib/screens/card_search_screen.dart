import 'package:activity_7/bloc/card_search_event.dart';
import 'package:activity_7/bloc/cart_search_bloc.dart';
import 'package:activity_7/bloc/cart_search_state.dart';
import 'package:activity_7/screens/card_detail_screen.dart';
import 'package:activity_7/widgets/card_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_core/shared_core.dart';

class CardSearchScreen extends StatefulWidget {
  const CardSearchScreen({super.key});

  @override
  State<CardSearchScreen> createState() => _CardSearchScreenState();
}

class _CardSearchScreenState extends State<CardSearchScreen> {
  final TextEditingController _controller = TextEditingController();

  void _submitSearch(String query) {
    context.read<CardSearchBloc>().add(SearchCardEvents(query));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Nav
            Padding(
              padding: EdgeInsets.all(20),
              child: SearchInput(
                controller: _controller,
                textInputAction: TextInputAction.search,
                hintText: 'Search for a card (e.g. robot)',
                onSubmitted: _submitSearch,
              ),
            ),
            // Body
            Expanded(
              child: BlocBuilder<CardSearchBloc, CardSearchState>(
                builder: (context, state) {
                  if (state is CardSearchInitial) {
                    return const CenteredMessage(
                      text: 'Type a card name above to search.',
                    );
                  }

                  if (state is CardSearchEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is CardSearchError) {
                    return CenteredMessage(
                      text: 'Something went wrong: ${state.message}',
                    );
                  }

                  final cards = (state as CardSearchLoaded).cards;
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 12),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return CardListTile(
                        card: card,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CardDetailScreen(card: card),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
