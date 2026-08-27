import 'package:activity_7b/bloc/cart_detail/card_detail_event.dart';
import 'package:activity_7b/bloc/cart_detail/card_detail_state.dart';
import 'package:activity_7b/repository/poke_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardDetailBloc extends Bloc<CardDetailEvent, CardDetailState> {
  final PokeRepository repository;

  CardDetailBloc({required this.repository})
    : super(const CardDetailLoading()) {
    on<FetchCardDetail>(_onFetchDetail);
  }

  Future<void> _onFetchDetail(
    FetchCardDetail event,
    Emitter<CardDetailState> emit,
  ) async {
    emit(const CardDetailLoading());
    try {
      final card = await repository.fetchCardDetail(event.nameOrId);
      emit(CardDetailLoaded(card));
    } catch (e) {
      emit(CardDetailError(e.toString()));
    }
  }
}
