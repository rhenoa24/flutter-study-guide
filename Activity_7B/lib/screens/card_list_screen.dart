import 'package:activity_7b/bloc/card_list/card_list_event.dart';
import 'package:activity_7b/bloc/card_list/card_list_state.dart';
import 'package:activity_7b/bloc/card_list/cart_list_bloc.dart';
import 'package:activity_7b/screens/card_detail_screen.dart';
import 'package:activity_7b/widgets/card_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({super.key});

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CardListBloc>().add(const FetchCardList());

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final threshold = _scrollController.position.maxScrollExtent - 200;
    if (_scrollController.position.pixels >= threshold) {
      context.read<CardListBloc>().add(const LoadMoreCard());
    }
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
      appBar: AppBar(title: const Text('Pokédex')),
      body: SafeArea(
        child: BlocBuilder<CardListBloc, CardListState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const _LoadingView();
            }

            if (state.errorMessage != null && state.items.isEmpty) {
              return _ErrorView(message: state.errorMessage!);
            }

            return _CardList(
              state: state,
              scrollController: _scrollController,
              onCardTap: (name) => _openDetail(context, name),
            );
          },
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
