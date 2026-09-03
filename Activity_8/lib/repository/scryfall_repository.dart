import 'dart:convert';

import 'package:activity_8/models/mtg_card.dart';
import 'package:http/http.dart' as http;

class NoMtgsFoundException implements Exception {}

class ScryfallRepository {
  static const _baseUrl = 'https://api.scryfall.com/cards/search';

  Future<MtgSearchResponse> searchMtgs(String query) async {
    final uri = Uri.parse(
      '$_baseUrl?order=name&q=${Uri.encodeQueryComponent(query)}',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      return MtgSearchResponse.fromJson(jsonBody);
    }

    if (response.statusCode == 404) {
      throw NoMtgsFoundException();
    }

    throw Exception('Scryfall request failed (status ${response.statusCode})');
  }

  Future<MtgCard> fetchRandomCard() async {
    final response = await http.get(
      Uri.parse('https://api.scryfall.com/cards/random'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch a random card (${response.statusCode})');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return MtgCard.fromJson(json);
  }
}
