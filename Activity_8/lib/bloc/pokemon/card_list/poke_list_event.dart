abstract class PokeListEvent {
  const PokeListEvent();
}

class FetchPokeList extends PokeListEvent {
  const FetchPokeList();
}

class LoadMorePoke extends PokeListEvent {
  const LoadMorePoke();
}
