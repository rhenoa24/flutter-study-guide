abstract class CardDetailEvent {
  const CardDetailEvent();
}

class FetchCardDetail extends CardDetailEvent {
  final String nameOrId;
  const FetchCardDetail(this.nameOrId);
}
