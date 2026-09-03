import 'package:activity_8/bloc/mtg/mtg_search_bloc.dart';
import 'package:activity_8/bloc/mtg/mtg_search_event.dart';
import 'package:activity_8/bloc/mtg/mtg_search_state.dart';
import 'package:activity_8/repository/scryfall_repository.dart';
import 'package:activity_8/screens/mtg/mtg_detail_screen.dart';
import 'package:activity_8/widgets/mtg/mtg_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_core/shared_core.dart';

class MtgSearchScreen extends StatefulWidget {
  const MtgSearchScreen({super.key});

  @override
  State<MtgSearchScreen> createState() => _CardSearchScreenState();
}

class _CardSearchScreenState extends State<MtgSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isFetchingRandom = false;

  void _submitSearch(String query) {
    context.read<MtgSearchBloc>().add(SearchMtgEvents(query));
  }

  Future<void> _fetchRandomCard() async {
    setState(() => _isFetchingRandom = true);
    try {
      final card = await context.read<ScryfallRepository>().fetchRandomCard();
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MtgDetailScreen(card: card)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not fetch a random card: $e')),
      );
    } finally {
      if (mounted) setState(() => _isFetchingRandom = false);
    }
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SearchInput(
                      controller: _controller,
                      textInputAction: TextInputAction.search,
                      hintText: 'Search for a card (e.g. robot)',
                      onSubmitted: _submitSearch,
                    ),
                  ),
                  FormIconButton(
                    icon: Icon(Icons.casino),
                    enabled: !_isFetchingRandom,
                    onPressed: _fetchRandomCard,
                  ),
                ],
              ),
            ),
            // Body
            Expanded(
              child: BlocBuilder<MtgSearchBloc, MtgSearchState>(
                builder: (context, state) {
                  if (state is MtgSearchInitial) {
                    return const CenteredMessage(
                      text: 'Type a card name above to search.',
                    );
                  }

                  if (state is MtgSearchEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is MtgSearchError) {
                    return CenteredMessage(
                      text: 'Something went wrong: ${state.message}',
                    );
                  }

                  final cards = (state as MtgSearchLoaded).cards;
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 12),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return MtgListTile(
                        card: card,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MtgDetailScreen(card: card),
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
