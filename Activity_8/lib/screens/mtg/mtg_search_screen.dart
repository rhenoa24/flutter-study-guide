import 'package:activity_8/bloc/mtg/mtg_function_bloc.dart';
import 'package:activity_8/bloc/mtg/mtg_function_event.dart';
import 'package:activity_8/bloc/mtg/mtg_function_state.dart';
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
    context.read<MtgFunctionBloc>().add(SearchMtgEvents(query));
  }

  void _fetchRandomCard() {
    context.read<MtgFunctionBloc>().add(FetchRandomMtgEvents());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<MtgFunctionBloc, MtgFunctionState>(
      listener: (context, state) {
        setState(() => _isFetchingRandom = true);
        if (state is MtgFetchRandomSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MtgDetailScreen(card: state.card),
            ),
          );
        } else if (state is MtgFetchRandomError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not fetch a random card: ${state.message}'),
            ),
          );
        }
        setState(() => _isFetchingRandom = false);
      },

      child: Scaffold(
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
                    const SizedBox(width: 8),
                    FormIconButton(
                      icon: Icons.casino,
                      enabled: !_isFetchingRandom,
                      onPressed: _fetchRandomCard,
                    ),
                  ],
                ),
              ),
              // Body
              Expanded(
                child: BlocBuilder<MtgFunctionBloc, MtgFunctionState>(
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

                    if (state is MtgSearchLoaded) {
                      final cards = state.cards;
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
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
