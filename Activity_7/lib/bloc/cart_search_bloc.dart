import 'package:activity_7/bloc/card_search_event.dart';
import 'package:activity_7/bloc/cart_search_state.dart';
import 'package:activity_7/repository/scryfall_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardSearchBloc extends Bloc<CardSearchEvent, CardSearchState> {
  final ScryfallRepository repository;

  CardSearchBloc({required this.repository}) : super(CardSearchInitial()) {
    on<SearchCardEvents>(_onSearchCards);
  }

  Future<void> _onSearchCards(
    SearchCardEvents event,
    Emitter<CardSearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(CardSearchInitial());
      return;
    }

    emit(CardSearchInitial());

    try {
      final result = await repository.searchCards(query);

      if (result.data.isEmpty) {
        emit(CardSearchEmpty(query));
      } else {
        emit(CardSearchLoaded(result.data));
      }
    } on NoCardsFoundException {
      emit(CardSearchError('No match found.'));
    } catch (e) {
      emit(CardSearchError(e.toString()));
    }
  }
}
