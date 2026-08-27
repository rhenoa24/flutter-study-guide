import 'package:activity_7b/models/poke_card.dart';
import 'package:equatable/equatable.dart';

class CardListState extends Equatable {
  final List<PokemonListItem> items;
  final int offset;
  final bool hasMore;
  final bool isLoading; // true only for the very first page
  final bool isLoadingMore; // true only while fetching page 2, 3, ...
  final String? errorMessage;

  const CardListState({
    this.items = const [],
    this.offset = 0,
    this.hasMore = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  const CardListState.initial() : this(isLoading: true);

  CardListState copyWith({
    List<PokemonListItem>? items,
    int? offset,
    bool? hasMore,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CardListState(
      items: items ?? this.items,
      offset: offset ?? this.offset,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    items,
    offset,
    hasMore,
    isLoading,
    isLoadingMore,
    errorMessage,
  ];
}
