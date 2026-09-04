abstract class MtgFunctionEvent {
  const MtgFunctionEvent();

  List<Object?> get props => [];
}

class SearchMtgEvents extends MtgFunctionEvent {
  final String query;
  const SearchMtgEvents(this.query);

  @override
  List<Object?> get props => [query];
}

class FetchRandomMtgEvents extends MtgFunctionEvent {}
