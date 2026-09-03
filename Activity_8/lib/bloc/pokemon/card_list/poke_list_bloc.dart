import 'package:activity_8/bloc/pokemon/card_list/poke_list_event.dart';
import 'package:activity_8/bloc/pokemon/card_list/poke_list_state.dart';
import 'package:activity_8/repository/poke_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const int kPageSize = 10;

class PokeListBloc extends Bloc<PokeListEvent, PokeListState> {
  final PokeRepository repository;

  PokeListBloc({required this.repository})
    : super(const PokeListState.initial()) {
    on<FetchPokeList>(_onFetchList);
    on<LoadMorePoke>(_onLoadMore);
  }

  Future<void> _onFetchList(
    FetchPokeList event,
    Emitter<PokeListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final result = await repository.fetchPokeList(
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
    LoadMorePoke event,
    Emitter<PokeListState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    emit(state.copyWith(isLoadingMore: true, clearError: true));

    try {
      final result = await repository.fetchPokeList(
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
