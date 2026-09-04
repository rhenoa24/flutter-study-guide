import 'package:activity_8/bloc/mtg/mtg_function_event.dart';
import 'package:activity_8/bloc/mtg/mtg_function_state.dart';
import 'package:activity_8/repository/scryfall_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MtgFunctionBloc extends Bloc<MtgFunctionEvent, MtgFunctionState> {
  final ScryfallRepository repository;

  MtgFunctionBloc({required this.repository}) : super(MtgSearchInitial()) {
    on<SearchMtgEvents>(_onSearchMtgs);
    on<FetchRandomMtgEvents>(_fetchRandomCard);
  }

  Future<void> _onSearchMtgs(
    SearchMtgEvents event,
    Emitter<MtgFunctionState> emit,
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

  Future<void> _fetchRandomCard(
    FetchRandomMtgEvents event,
    Emitter<MtgFunctionState> emit,
  ) async {
    try {
      final result = await repository.fetchRandomCard();

      if (result.name.isEmpty) {
        emit(MtgFetchRandomError('Not found.'));
      } else {
        emit(MtgFetchRandomSuccess(result));
      }
    } on NoMtgsFoundException {
      emit(MtgSearchError('No match found.'));
    } catch (e) {
      emit(MtgSearchError(e.toString()));
    }
  }

  // Future<void> _fetchRandomCard() async {
  //   setState(() => _isFetchingRandom = true);
  //   try {
  //     final card = await context.read<ScryfallRepository>().fetchRandomCard();
  //     if (!mounted) return;
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (_) => MtgDetailScreen(card: card)),
  //     );
  //   } catch (e) {
  //     if (!mounted) return;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Could not fetch a random card: $e')),
  //     );
  //   } finally {
  //     if (mounted) setState(() => _isFetchingRandom = false);
  //   }
  // }
}
