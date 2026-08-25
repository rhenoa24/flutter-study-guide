import 'package:activity_7/models/mtg_card.dart';
import 'package:equatable/equatable.dart';

abstract class CardSearchState extends Equatable {
  const CardSearchState();

  @override
  List<Object?> get props => [];
}

class CardSearchInitial extends CardSearchState {}

class CardSearchLoading extends CardSearchState {}

class CardSearchLoaded extends CardSearchState {
  final List<MtgCard> cards;

  const CardSearchLoaded(this.cards);

  @override
  List<Object?> get props => [cards];
}

class CardSearchEmpty extends CardSearchState {
  final String query;

  const CardSearchEmpty(this.query);

  @override
  List<Object?> get props => [query];
}

class CardSearchError extends CardSearchState {
  final String message;
  const CardSearchError(this.message);

  @override
  List<Object?> get props => [message];
}
