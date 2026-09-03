abstract class PokeDetailEvent {
  const PokeDetailEvent();
}

class FetchPokeDetail extends PokeDetailEvent {
  final String nameOrId;
  const FetchPokeDetail(this.nameOrId);
}
