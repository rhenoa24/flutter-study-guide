abstract class CardSearchEvent {
  const CardSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchCardsEvents extends CardSearchEvent {
  final String query;
  const SearchCardsEvents(this.query);

  @override
  List<Object?> get props => [query];
}
