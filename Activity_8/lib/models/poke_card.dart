class PokemonListItem {
  final String name;
  final String url;

  const PokemonListItem({required this.name, required this.url});

  int get id {
    final segments = url.split('/')..removeWhere((s) => s.isEmpty);
    return int.tryParse(segments.last) ?? 0;
  }

  String get thumbnailUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(name: json['name'] ?? '', url: json['url'] ?? '');
  }

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}

class PokemonListResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonListItem> results;

  const PokemonListResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  bool get hasMore => next != null;

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListResponse(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>? ?? [])
          .map((e) => PokemonListItem.fromJson(e))
          .toList(),
    );
  }
}

class PokemonType {
  final String name;
  const PokemonType({required this.name});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(name: json['type']?['name'] ?? '');
  }
}

class PokemonAbility {
  final String name;
  final bool isHidden;
  const PokemonAbility({required this.name, required this.isHidden});

  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    return PokemonAbility(
      name: json['ability']?['name'] ?? '',
      isHidden: json['is_hidden'] ?? false,
    );
  }
}

class PokemonStat {
  final String name;
  final int baseStat;
  const PokemonStat({required this.name, required this.baseStat});

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      name: json['stat']?['name'] ?? '',
      baseStat: json['base_stat'] ?? 0,
    );
  }
}

class PokemonSprites {
  final String? frontDefault;
  final String? officialArtwork;

  const PokemonSprites({this.frontDefault, this.officialArtwork});

  String? get bestImage => officialArtwork ?? frontDefault;

  factory PokemonSprites.fromJson(Map<String, dynamic> json) {
    final other = json['other'] as Map<String, dynamic>?;
    final artwork = other?['official-artwork'] as Map<String, dynamic>?;
    return PokemonSprites(
      frontDefault: json['front_default'],
      officialArtwork: artwork?['front_default'],
    );
  }
}

class PokemonDetail {
  final int id;
  final String name;
  final int height;
  final int weight;
  final int baseExperience;
  final List<PokemonType> types;
  final List<PokemonAbility> abilities;
  final List<PokemonStat> stats;
  final PokemonSprites sprites;

  const PokemonDetail({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.types,
    required this.abilities,
    required this.stats,
    required this.sprites,
  });

  double get heightInMeters => height / 10;
  double get weightInKg => weight / 10;

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      baseExperience: json['base_experience'] ?? 0,
      types: (json['types'] as List<dynamic>? ?? [])
          .map((e) => PokemonType.fromJson(e))
          .toList(),
      abilities: (json['abilities'] as List<dynamic>? ?? [])
          .map((e) => PokemonAbility.fromJson(e))
          .toList(),
      stats: (json['stats'] as List<dynamic>? ?? [])
          .map((e) => PokemonStat.fromJson(e))
          .toList(),
      sprites: json['sprites'] != null
          ? PokemonSprites.fromJson(json['sprites'])
          : const PokemonSprites(),
    );
  }
}
