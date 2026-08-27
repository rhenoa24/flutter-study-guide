import 'package:activity_7b/bloc/card_list/card_list_event.dart';
import 'package:activity_7b/bloc/card_list/card_list_state.dart';
import 'package:activity_7b/repository/poke_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const int kPageSize = 10;

class CardListBloc extends Bloc<CardListEvent, CardListState> {
  final PokeRepository repository;

  CardListBloc({required this.repository})
    : super(const CardListState.initial()) {
    on<FetchCardList>(_onFetchList);
    on<LoadMoreCard>(_onLoadMore);
  }

  Future<void> _onFetchList(
    FetchCardList event,
    Emitter<CardListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final result = await repository.fetchCardList(
        limit: kPageSize,
        offset: 0,
      );

      emit(
        state.copyWith(
          items: result.results,
          offset: kPageSize,
          hasMore: result.hasMore,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onLoadMore(
    LoadMoreCard event,
    Emitter<CardListState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    emit(state.copyWith(isLoadingMore: true, clearError: true));

    try {
      final result = await repository.fetchCardList(
        limit: kPageSize,
        offset: state.offset,
      );

      emit(
        state.copyWith(
          items: [...state.items, ...result.results],
          offset: state.offset + kPageSize,
          hasMore: result.hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, errorMessage: e.toString()));
    }
  }
}
