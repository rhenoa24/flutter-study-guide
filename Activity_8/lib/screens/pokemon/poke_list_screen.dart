import 'package:activity_8/bloc/pokemon/card_list/poke_list_event.dart';
import 'package:activity_8/bloc/pokemon/card_list/poke_list_state.dart';
import 'package:activity_8/bloc/pokemon/card_list/poke_list_bloc.dart';
import 'package:activity_8/screens/pokemon/poke_detail_screen.dart';
import 'package:activity_8/widgets/pokemon/poke_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_core/shared_core.dart';

class PokeListScreen extends StatefulWidget {
  const PokeListScreen({super.key});

  @override
  State<PokeListScreen> createState() => _PokeListScreenState();
}

class _PokeListScreenState extends State<PokeListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<PokeListBloc>().add(const FetchPokeList());

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
    final screenHeight = MediaQuery.of(context).size.height;
    final threshold =
        _scrollController.position.maxScrollExtent - (screenHeight * 0.5);
    if (_scrollController.position.pixels >= threshold) {
      context.read<PokeListBloc>().add(const LoadMorePoke());
    }
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.trim().toLowerCase();
      _maybeAutoLoad(context.read<PokeListBloc>().state);
    });
  }

  void _maybeAutoLoad(PokeListState state) {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    if (_searchQuery.isNotEmpty) {
      final hasMatch = state.items.any(
        (p) => p.name.toLowerCase().contains(_searchQuery),
      );

      if (!hasMatch) {
        context.read<PokeListBloc>().add(const LoadMorePoke());
      }
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      if (_scrollController.position.maxScrollExtent <= 0) {
        context.read<PokeListBloc>().add(const LoadMorePoke());
      }
    });
  }

  void _openDetail(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PokeDetailScreen(name: name)),
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
              child: BlocBuilder<PokeListBloc, PokeListState>(
                // listener: (context, state) => _maybeAutoLoad(state),
                builder: (context, state) {
                  // print('query: $_searchQuery');

                  if (state.isLoading) {
                    return const LoadingView();
                  }

                  if (state.errorMessage != null && state.items.isEmpty) {
                    return ErrorView(message: state.errorMessage!);
                  }

                  if (_searchQuery.isNotEmpty) {
                    _maybeAutoLoad(state);
                    final matches = state.items
                        .where(
                          (p) => p.name.toLowerCase().contains(_searchQuery),
                        )
                        .toList();

                    return _FilteredPokeList(
                      items: matches,
                      hasMoreLoad: state.hasMore,
                      scrollController: _scrollController,
                      onPokeTap: (name) => _openDetail(context, name),
                    );
                  }

                  return _PokeList(
                    state: state,
                    scrollController: _scrollController,
                    onPokeTap: (name) => _openDetail(context, name),
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

class _PokeList extends StatelessWidget {
  final PokeListState state;
  final ScrollController scrollController;
  final ValueChanged<String> onPokeTap;

  const _PokeList({
    required this.state,
    required this.scrollController,
    required this.onPokeTap,
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
          return const LoadingMoreIndicator();
        }

        final pokemon = state.items[index];
        return PokeListTile(
          id: pokemon.id,
          name: pokemon.name,
          imageUrl: pokemon.thumbnailUrl,
          onTap: () => onPokeTap(pokemon.name),
        );
      },
    );
  }
}

class _FilteredPokeList extends StatelessWidget {
  final List<dynamic> items;
  final bool hasMoreLoad;
  final ScrollController scrollController;
  final ValueChanged<String> onPokeTap;

  const _FilteredPokeList({
    required this.items,
    required this.hasMoreLoad,
    required this.scrollController,
    required this.onPokeTap,
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
        return PokeListTile(
          id: pokemon.id,
          name: pokemon.name,
          imageUrl: pokemon.thumbnailUrl,
          onTap: () => onPokeTap(pokemon.name),
        );
      },
    );
  }
}
