import 'package:activity_8/bloc/pokemon/cart_detail/poke_detail_bloc.dart';
import 'package:activity_8/bloc/pokemon/cart_detail/poke_detail_event.dart';
import 'package:activity_8/bloc/pokemon/cart_detail/poke_detail_state.dart';
import 'package:activity_8/models/poke_type.dart';
import 'package:activity_8/repository/poke_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_core/shared_core.dart';

class PokeDetailScreen extends StatelessWidget {
  final String name;
  const PokeDetailScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PokeDetailBloc(repository: PokeRepository())
            ..add(FetchPokeDetail(name)),
      child: const _PokeDetailView(),
    );
  }
}

class _PokeDetailView extends StatelessWidget {
  const _PokeDetailView();

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
              child: BlocBuilder<PokeDetailBloc, PokeDetailState>(
                builder: ((context, state) {
                  if (state is PokeDetailLoading) {
                    return LoadingView();
                  }

                  if (state is PokeDetailError) {
                    return ErrorView(message: state.message);
                  }

                  final pokemon = (state as PokeDetailLoaded).card;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (pokemon.sprites.bestImage != null)
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ImageViewer(
                                  imageUrl: pokemon.sprites.bestImage!,
                                ),
                              ),
                            ),
                            child: Hero(
                              tag: pokemon.sprites.bestImage!,
                              child: FramedImage(
                                imageUrl: pokemon.sprites.bestImage!,
                              ),
                            ),
                          ),

                        const SizedBox(height: 16),
                        //
                        TitleTrail(
                          title: _capitalize(pokemon.name),
                          trailingText:
                              '#${pokemon.id.toString().padLeft(3, '0')}',
                        ),

                        //
                        const SizedBox(height: 8),
                        //
                        TypeTag(
                          tags: pokemon.types
                              .map((t) => _capitalize(t.name))
                              .toList(),
                          tagColors: pokemon.types
                              .map((t) => colorForType(t.name))
                              .toList(),
                        ),

                        const SizedBox(height: 16),

                        //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            StatColumn(
                              label: 'Height',
                              value: '${pokemon.heightInMeters} m',
                            ),
                            StatColumn(
                              label: 'Weight',
                              value: '${pokemon.weightInKg} kg',
                            ),
                            StatColumn(
                              label: 'Base XP',
                              value: '${pokemon.baseExperience}',
                            ),
                          ],
                        ),
                        //
                        const SizedBox(height: 20),

                        DividedText(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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

                              if (pokemon.description != null &&
                                  pokemon.description!.isNotEmpty) ...[
                                const SizedBox(height: 20),
                                Text(
                                  'Description',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(pokemon.description!),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          'Base Stats',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ...pokemon.stats.map(
                          (s) => StatBar(
                            label: s.name.replaceAll('-', ' ').toUpperCase(),
                            value: s.baseStat,
                          ),
                        ),
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
