import 'package:activity_8/bloc/mtg/mtg_search_event.dart';
import 'package:activity_8/bloc/mtg/mtg_search_state.dart';
import 'package:activity_8/repository/scryfall_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MtgSearchBloc extends Bloc<MtgSearchEvent, MtgSearchState> {
  final ScryfallRepository repository;

  MtgSearchBloc({required this.repository}) : super(MtgSearchInitial()) {
    on<SearchMtgEvents>(_onSearchMtgs);
  }

  Future<void> _onSearchMtgs(
    SearchMtgEvents event,
    Emitter<MtgSearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(MtgSearchInitial());
      return;
    }

    emit(MtgSearchInitial());

    try {
      final result = await repository.searchMtgs(query);

      if (result.data.isEmpty) {
        emit(MtgSearchEmpty(query));
      } else {
        emit(MtgSearchLoaded(result.data));
      }
    } on NoMtgsFoundException {
      emit(MtgSearchError('No match found.'));
    } catch (e) {
      emit(MtgSearchError(e.toString()));
    }
  }
}
