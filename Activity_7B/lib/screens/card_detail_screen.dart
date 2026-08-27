import 'package:activity_7b/bloc/cart_detail/card_detail.bloc.dart';
import 'package:activity_7b/bloc/cart_detail/card_detail_event.dart';
import 'package:activity_7b/repository/poke_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(backgroundColor: colorScheme.surface);
  }
}
