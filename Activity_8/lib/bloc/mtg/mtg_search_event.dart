abstract class MtgSearchEvent {
  const MtgSearchEvent();

  List<Object?> get props => [];
}

class SearchMtgEvents extends MtgSearchEvent {
  final String query;
  const SearchMtgEvents(this.query);

  @override
  List<Object?> get props => [query];
}
