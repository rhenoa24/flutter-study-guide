import 'package:activity_8/models/mtg_card.dart';
import 'package:equatable/equatable.dart';

abstract class MtgSearchState extends Equatable {
  const MtgSearchState();

  @override
  List<Object?> get props => [];
}

class MtgSearchInitial extends MtgSearchState {}

class MtgSearchLoading extends MtgSearchState {}

class MtgSearchLoaded extends MtgSearchState {
  final List<MtgCard> cards;

  const MtgSearchLoaded(this.cards);

  @override
  List<Object?> get props => [cards];
}

class MtgSearchEmpty extends MtgSearchState {
  final String query;

  const MtgSearchEmpty(this.query);

  @override
  List<Object?> get props => [query];
}

class MtgSearchError extends MtgSearchState {
  final String message;
  const MtgSearchError(this.message);

  @override
  List<Object?> get props => [message];
}
