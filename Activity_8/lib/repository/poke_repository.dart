import 'dart:convert';

import 'package:activity_8/models/poke_card.dart';
import 'package:http/http.dart' as http;

class PokeApiException implements Exception {
  final String message;
  PokeApiException(this.message);

  @override
  String toString() => message;
}

class PokeRepository {
  static const _baseUrl = 'https://pokeapi.co/api/v2';

  Future<PokemonListResponse> fetchPokeList({
    int limit = 10,
    int offset = 0,
  }) async {
    final uri = Uri.parse('$_baseUrl/pokemon?limit=$limit&offset=$offset');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      return PokemonListResponse.fromJson(jsonBody);
    }

    throw PokeApiException('Failed to load pokemon (${response.statusCode})');
  }

  Future<PokemonDetail> fetchPokeDetail(String nameOrId) async {
    final uri = Uri.parse('$_baseUrl/pokemon/$nameOrId');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      return PokemonDetail.fromJson(jsonBody);
    }

    if (response.statusCode == 404) {
      throw PokeApiException('Pokemon "$nameOrId" not found');
    }

    throw PokeApiException(
      'Failed to load pokemon detail (${response.statusCode})',
    );
  }

  Future<String?> fetchPokeDescription(String nameOrId) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$nameOrId'),
    );

    if (response.statusCode != 200) return null;

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final entries = (json['flavor_text_entries'] as List<dynamic>? ?? []);

    final englishEntry = entries.cast<Map<String, dynamic>>().firstWhere(
      (e) => e['language']?['name'] == 'en',
      orElse: () => const {},
    );

    final raw = englishEntry['flavor_text'] as String?;
    // pokemon-species flavor text is riddled with \n and \f line breaks
    return raw?.replaceAll(RegExp(r'[\n\f\r]'), ' ').trim();
  }
}
