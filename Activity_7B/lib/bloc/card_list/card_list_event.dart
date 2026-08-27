abstract class CardListEvent {
  const CardListEvent();
}

class FetchCardList extends CardListEvent {
  const FetchCardList();
}

class LoadMoreCard extends CardListEvent {
  const LoadMoreCard();
}
