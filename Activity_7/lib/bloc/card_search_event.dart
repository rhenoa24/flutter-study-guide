abstract class CardSearchEvent {
  const CardSearchEvent();

  List<Object?> get props => [];
}

class SearchCardEvents extends CardSearchEvent {
  final String query;
  const SearchCardEvents(this.query);

  @override
  List<Object?> get props => [query];
}
