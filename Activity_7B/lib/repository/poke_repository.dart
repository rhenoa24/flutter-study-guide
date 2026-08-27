import 'dart:convert';

import 'package:activity_7b/models/poke_card.dart';
import 'package:http/http.dart' as http;

class PokeApiException implements Exception {
  final String message;
  PokeApiException(this.message);

  @override
  String toString() => message;
}

class PokeRepository {
  static const _baseUrl = 'https://pokeapi.co/api/v2';

  Future<PokemonListResponse> fetchCardList({
    int limit = 10,
    int offset = 0,
  }) async {
    final uri = Uri.parse('$_baseUrl/Card?limit=$limit&offset=$offset');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      return PokemonListResponse.fromJson(jsonBody);
    }

    throw PokeApiException('Failed to load Card (${response.statusCode})');
  }

  Future<PokemonDetail> fetchCardDetail(String nameOrId) async {
    final uri = Uri.parse('$_baseUrl/Card/$nameOrId');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      return PokemonDetail.fromJson(jsonBody);
    }

    if (response.statusCode == 404) {
      throw PokeApiException('Card "$nameOrId" not found');
    }

    throw PokeApiException(
      'Failed to load Card detail (${response.statusCode})',
    );
  }
}
