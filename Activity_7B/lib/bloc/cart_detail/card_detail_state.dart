import 'package:activity_7b/models/poke_card.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class CardDetailState extends Equatable {
  const CardDetailState();

  @override
  List<Object?> get props => [];
}

class CardDetailLoading extends CardDetailState {
  const CardDetailLoading();
}

class CardDetailLoaded extends CardDetailState {
  final PokemonDetail card;
  const CardDetailLoaded(this.card);

  @override
  List<Object?> get props => [connectedVmServiceUri];
}

class CardDetailError extends CardDetailState {
  final String message;
  const CardDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
