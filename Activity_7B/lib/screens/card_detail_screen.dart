import 'package:activity_7b/bloc/cart_detail/card_detail.bloc.dart';
import 'package:activity_7b/bloc/cart_detail/card_detail_event.dart';
import 'package:activity_7b/bloc/cart_detail/card_detail_state.dart';
import 'package:activity_7b/models/poke_card.dart';
import 'package:activity_7b/repository/poke_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/widgets/app_bar.dart';

class CardDetailScreen extends StatelessWidget {
  final String name;
  const CardDetailScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CardDetailBloc(repository: PokeRepository())
            ..add(FetchCardDetail(name)),
      child: const _CardDetailView(),
    );
  }
}

class _CardDetailView extends StatelessWidget {
  const _CardDetailView();

  static String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

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
              padding: EdgeInsets.all(10),
              child: TopAppBar(
                label: 'Pokémon Details',
                onPressed: () => Navigator.pop(context),
              ),
            ),
            // Body
            Expanded(
              child: BlocBuilder<CardDetailBloc, CardDetailState>(
                builder: ((context, state) {
                  if (state is CardDetailLoading) {
                    return _LoadingView();
                  }

                  if (state is CardDetailError) {
                    return _ErrorView(message: state.message);
                  }

                  final pokemon = (state as CardDetailLoaded).card;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (pokemon.sprites.bestImage != null)
                          Center(
                            child: Image.network(
                              pokemon.sprites.bestImage!,
                              height: 220,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.image_not_supported,
                                    size: 100,
                                  ),
                            ),
                          ),
                        const SizedBox(height: 16),
                        //
                        Row(
                          children: [
                            Text(
                              _capitalize(pokemon.name),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            //
                            const Spacer(),
                            //
                            Text(
                              '#${pokemon.id.toString().padLeft(3, '0')}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primaryContainer,
                              ),
                            ),
                          ],
                        ),
                        //
                        const SizedBox(height: 8),
                        //
                        Wrap(
                          spacing: 8,
                          children: pokemon.types
                              .map(
                                (t) => Chip(label: Text(_capitalize(t.name))),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                        //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatColumn(
                              label: 'Height',
                              value: '${pokemon.heightInMeters} m',
                            ),
                            _StatColumn(
                              label: 'Weight',
                              value: '${pokemon.weightInKg} kg',
                            ),
                            _StatColumn(
                              label: 'Base XP',
                              value: '${pokemon.baseExperience}',
                            ),
                          ],
                        ),
                        //
                        const SizedBox(height: 20),

                        Text(
                          'Abilities',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        ...pokemon.abilities.map(
                          (a) => Text(
                            '${_capitalize(a.name)}${a.isHidden ? ' (hidden)' : ''}',
                          ),
                        ),
                        const SizedBox(height: 20),

                        Text(
                          'Base Stats',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ...pokemon.stats.map((s) => _StatBar(stat: s)),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
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

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          label,
          style: TextStyle(color: Theme.of(context).colorScheme.outline),
        ),
      ],
    );
  }
}

class _StatBar extends StatelessWidget {
  final PokemonStat stat;
  const _StatBar({required this.stat});

  @override
  Widget build(BuildContext context) {
    // Base stats top out around 255 in practice; clamp so the bar never
    // overflows for unusually high values.
    final ratio = (stat.baseStat / 255).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(stat.name.replaceAll('-', ' ').toUpperCase()),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(value: ratio, minHeight: 8),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 30,
            child: Text('${stat.baseStat}', textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
