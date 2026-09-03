import 'package:activity_8/models/poke_card.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class PokeDetailState extends Equatable {
  const PokeDetailState();

  @override
  List<Object?> get props => [];
}

class PokeDetailLoading extends PokeDetailState {
  const PokeDetailLoading();
}

class PokeDetailLoaded extends PokeDetailState {
  final PokemonDetail card;
  const PokeDetailLoaded(this.card);

  @override
  List<Object?> get props => [connectedVmServiceUri];
}

class PokeDetailError extends PokeDetailState {
  final String message;
  const PokeDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
