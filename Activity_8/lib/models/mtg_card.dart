// Wraps the image links
class ImageUris {
  final String small;
  final String normal;
  final String large;
  final String png;
  final String artCrop;
  final String borderCrop;
  final String? thumb;
  final String? grid;
  final String? art;
  final String? crop;

  const ImageUris({
    required this.small,
    required this.normal,
    required this.large,
    required this.png,
    required this.artCrop,
    required this.borderCrop,
    this.thumb,
    this.grid,
    this.art,
    this.crop,
  });

  factory ImageUris.fromJson(Map<String, dynamic> json) {
    return ImageUris(
      small: json['small'] ?? '',
      normal: json['normal'] ?? '',
      large: json['large'] ?? '',
      png: json['png'] ?? '',
      artCrop: json['art_crop'] ?? '',
      borderCrop: json['border_crop'] ?? '',
      thumb: json['thumb'],
      grid: json['grid'],
      art: json['art'],
      crop: json['crop'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'small': small,
      'normal': normal,
      'large': large,
      'png': png,
      'art_crop': artCrop,
      'border_crop': borderCrop,
      'thumb': thumb,
      'grid': grid,
      'art': art,
      'crop': crop,
    };
  }
}

class CardFace {
  final String name;
  final String? manaCost;
  final String typeLine;
  final String? oracleText;
  final String? power;
  final String? toughness;
  final ImageUris? imageUris;

  const CardFace({
    required this.name,
    this.manaCost,
    required this.typeLine,
    this.oracleText,
    this.power,
    this.toughness,
    this.imageUris,
  });

  factory CardFace.fromJson(Map<String, dynamic> json) {
    return CardFace(
      name: json['name'] ?? '',
      manaCost: json['mana_cost'],
      typeLine: json['type_line'] ?? '',
      oracleText: json['oracle_text'],
      power: json['power'],
      toughness: json['toughness'],
      imageUris: json['image_uris'] != null
          ? ImageUris.fromJson(json['image_uris'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mana_cost': manaCost,
      'type_line': typeLine,
      'oracle_text': oracleText,
      'power': power,
      'toughness': toughness,
      'image_uris': imageUris?.toJson(),
    };
  }
}

class Legalities {
  final Map<String, String> byFormat;
  const Legalities(this.byFormat);

  factory Legalities.fromJson(Map<String, dynamic> json) {
    return Legalities(
      json.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  Map<String, dynamic> toJson() => byFormat;

  bool isLegalIn(String format) => byFormat[format] == 'legal';
}

// Single MTG card
class MtgCard {
  final String id;
  final String oracleId;
  final String name;
  final String lang;
  final String? releasedAt;
  final String scryfallUri;
  final String layout;
  final String? manaCost;
  final double cmc;
  final String typeLine;
  final String? oracleText;
  final String? power;
  final String? toughness;
  final List<String> colors;
  final List<String> colorIdentity;
  final List<String> keywords;
  final String setName;
  final String rarity;
  final Legalities legalities;
  final ImageUris? imageUris;
  final List<CardFace> cardFaces;

  const MtgCard({
    required this.id,
    required this.oracleId,
    required this.name,
    required this.lang,
    this.releasedAt,
    required this.scryfallUri,
    required this.layout,
    this.manaCost,
    required this.cmc,
    required this.typeLine,
    this.oracleText,
    this.power,
    this.toughness,
    required this.colors,
    required this.colorIdentity,
    required this.keywords,
    required this.setName,
    required this.rarity,
    required this.legalities,
    this.imageUris,
    this.cardFaces = const [],
  });

  bool get isMultiFaced => cardFaces.isNotEmpty;

  ImageUris? get displayImageUris {
    if (imageUris != null) return imageUris;
    if (cardFaces.isNotEmpty) return cardFaces.first.imageUris;
    return null;
  }

  factory MtgCard.fromJson(Map<String, dynamic> json) {
    return MtgCard(
      id: json['id'] ?? '',
      oracleId: json['oracle_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      lang: json['lang'] ?? 'en',
      releasedAt: json['released_at'],
      scryfallUri: json['scryfall_uri'] ?? '',
      layout: json['layout'] ?? 'normal',
      manaCost: json['mana_cost'],
      cmc: (json['cmc'] is num) ? (json['cmc'] as num).toDouble() : 0.0,
      typeLine: json['type_line'] ?? '',
      oracleText: json['oracle_text'],
      power: json['power'],
      toughness: json['toughness'],
      colors:
          (json['colors'] as List<dynamic>?)
              ?.map((c) => c.toString())
              .toList() ??
          const [],
      colorIdentity:
          (json['color_identity'] as List<dynamic>?)
              ?.map((c) => c.toString())
              .toList() ??
          const [],
      keywords:
          (json['keywords'] as List<dynamic>?)
              ?.map((k) => k.toString())
              .toList() ??
          const [],
      setName: json['set_name'] ?? '',
      rarity: json['rarity'] ?? '',
      legalities: json['legalities'] != null
          ? Legalities.fromJson(json['legalities'])
          : const Legalities({}),
      imageUris: json['image_uris'] != null
          ? ImageUris.fromJson(json['image_uris'])
          : null,
      cardFaces:
          (json['card_faced'] as List<dynamic>?)
              ?.map((f) => CardFace.fromJson(f))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'oracle_id': oracleId,
      'name': name,
      'lang': lang,
      'released_at': releasedAt,
      'scryfall_uri': scryfallUri,
      'layout': layout,
      'mana_cost': manaCost,
      'cmc': cmc,
      'type_line': typeLine,
      'oracle_text': oracleText,
      'power': power,
      'toughness': toughness,
      'colors': colors,
      'color_identity': colorIdentity,
      'keywords': keywords,
      'set_name': setName,
      'rarity': rarity,
      'legalities': legalities.toJson(),
      'image_uris': imageUris?.toJson(),
      'card_faces': cardFaces.map((f) => f.toJson()).toList(),
    };
  }
}

class MtgSearchResponse {
  final int totalCards;
  final bool hasMore;
  final List<MtgCard> data;

  const MtgSearchResponse({
    required this.totalCards,
    required this.hasMore,
    required this.data,
  });

  factory MtgSearchResponse.fromJson(Map<String, dynamic> json) {
    return MtgSearchResponse(
      totalCards: json['total_cards'] ?? 0,
      hasMore: json['has_more'] ?? false,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((cardJson) => MtgCard.fromJson(cardJson))
          .toList(),
    );
  }
}
