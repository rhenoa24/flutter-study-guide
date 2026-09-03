import 'package:activity_8/bloc/pokemon/cart_detail/poke_detail_event.dart';
import 'package:activity_8/bloc/pokemon/cart_detail/poke_detail_state.dart';
import 'package:activity_8/repository/poke_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokeDetailBloc extends Bloc<PokeDetailEvent, PokeDetailState> {
  final PokeRepository repository;

  PokeDetailBloc({required this.repository})
    : super(const PokeDetailLoading()) {
    on<FetchPokeDetail>(_onFetchDetail);
  }

  Future<void> _onFetchDetail(
    FetchPokeDetail event,
    Emitter<PokeDetailState> emit,
  ) async {
    emit(const PokeDetailLoading());
    try {
      final card = await repository.fetchPokeDetail(event.nameOrId);

      String? description;
      try {
        description = await repository.fetchPokeDescription(event.nameOrId);
      } catch (_) {
        description = null; // non-critical — show the card without it
      }

      emit(PokeDetailLoaded(card.copyWith(description: description)));
    } catch (e) {
      emit(PokeDetailError(e.toString()));
    }
  }
}
