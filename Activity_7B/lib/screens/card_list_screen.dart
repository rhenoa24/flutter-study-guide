import 'package:activity_7b/bloc/card_list/card_list_event.dart';
import 'package:activity_7b/bloc/card_list/card_list_state.dart';
import 'package:activity_7b/bloc/card_list/cart_list_bloc.dart';
import 'package:activity_7b/screens/card_detail_screen.dart';
import 'package:activity_7b/widgets/card_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/widgets/search_input.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({super.key});

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<CardListBloc>().add(const FetchCardList());

    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final threshold = _scrollController.position.maxScrollExtent - 200;
    if (_scrollController.position.pixels >= threshold) {
      context.read<CardListBloc>().add(const LoadMoreCard());
    }
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.trim().toLowerCase();
      _maybeAutoLoad(context.read<CardListBloc>().state);
    });
  }

  void _maybeAutoLoad(CardListState state) {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    if (_searchQuery.isNotEmpty) {
      final hasMatch = state.items.any(
        (p) => p.name.toLowerCase().contains(_searchQuery),
      );

      if (!hasMatch) {
        context.read<CardListBloc>().add(const LoadMoreCard());
      }
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      if (_scrollController.position.maxScrollExtent <= 0) {
        context.read<CardListBloc>().add(const LoadMoreCard());
      }
    });
  }

  void _openDetail(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CardDetailScreen(name: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      // appBar: AppBar(title: const Text('Pokédex')),
      body: SafeArea(
        child: Column(
          children: [
            // Nav
            Padding(
              padding: EdgeInsets.all(20),
              child: SearchInput(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                hintText: 'Search for a Pokémon (e.g. Ditto)',
                onSubmitted: (_) => _onSearchChanged,
              ),
            ),
            // Body
            Expanded(
              child: BlocConsumer<CardListBloc, CardListState>(
                listener: (context, state) => _maybeAutoLoad(state),
                builder: (context, state) {
                  if (state.isLoading) {
                    return const _LoadingView();
                  }

                  if (state.errorMessage != null && state.items.isEmpty) {
                    return _ErrorView(message: state.errorMessage!);
                  }

                  if (_searchQuery.isNotEmpty) {
                    final matches = state.items
                        .where(
                          (p) => p.name.toLowerCase().contains(_searchQuery),
                        )
                        .toList();

                    return _FilteredCardList(
                      items: matches,
                      hasMoreLoad: state.hasMore,
                      scrollController: _scrollController,
                      onCardTap: (name) => _openDetail(context, name),
                    );
                  }

                  return _CardList(
                    state: state,
                    scrollController: _scrollController,
                    onCardTap: (name) => _openDetail(context, name),
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

class _CardList extends StatelessWidget {
  final CardListState state;
  final ScrollController scrollController;
  final ValueChanged<String> onCardTap;

  const _CardList({
    required this.state,
    required this.scrollController,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    // +1 reserves a trailing slot for the "loading more" spinner, only
    // while there's actually another page to fetch.
    final itemCount = state.items.length + (state.hasMore ? 1 : 0);

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.only(bottom: 12),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index >= state.items.length) {
          return const _LoadingMoreIndicator();
        }

        final pokemon = state.items[index];
        return CardListTile(
          id: pokemon.id,
          name: pokemon.name,
          imageUrl: pokemon.thumbnailUrl,
          onTap: () => onCardTap(pokemon.name),
        );
      },
    );
  }
}

class _FilteredCardList extends StatelessWidget {
  final List<dynamic> items;
  final bool hasMoreLoad;
  final ScrollController scrollController;
  final ValueChanged<String> onCardTap;

  const _FilteredCardList({
    required this.items,
    required this.hasMoreLoad,
    required this.scrollController,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            // hasMoreLoad ? 'No matches yet - keep scrolling to load more pokemon.' :
            'No matches found.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.only(bottom: 12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final pokemon = items[index];
        return CardListTile(
          id: pokemon.id,
          name: pokemon.name,
          imageUrl: pokemon.thumbnailUrl,
          onTap: () => onCardTap(pokemon.name),
        );
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _LoadingMoreIndicator extends StatelessWidget {
  const _LoadingMoreIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text('Something went wrong: $message'),
      ),
    );
  }
}
