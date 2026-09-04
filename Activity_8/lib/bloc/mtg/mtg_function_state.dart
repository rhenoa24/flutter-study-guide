import 'package:activity_8/models/mtg_card.dart';
import 'package:equatable/equatable.dart';

abstract class MtgFunctionState extends Equatable {
  const MtgFunctionState();

  @override
  List<Object?> get props => [];
}

class MtgSearchInitial extends MtgFunctionState {}

class MtgSearchLoading extends MtgFunctionState {}

class MtgSearchLoaded extends MtgFunctionState {
  final List<MtgCard> cards;

  const MtgSearchLoaded(this.cards);

  @override
  List<Object?> get props => [cards];
}

class MtgSearchEmpty extends MtgFunctionState {
  final String query;

  const MtgSearchEmpty(this.query);

  @override
  List<Object?> get props => [query];
}

class MtgSearchError extends MtgFunctionState {
  final String message;
  const MtgSearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class MtgFetchRandom extends MtgFunctionState {}

class MtgFetchRandomSuccess extends MtgFunctionState {
  final MtgCard card;

  const MtgFetchRandomSuccess(this.card);

  @override
  List<Object?> get props => [card];
}

class MtgFetchRandomError extends MtgFunctionState {
  final String message;
  const MtgFetchRandomError(this.message);

  @override
  List<Object?> get props => [message];
}
