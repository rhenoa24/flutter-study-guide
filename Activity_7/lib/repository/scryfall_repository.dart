import 'dart:convert';

import 'package:activity_7/models/mtg_card.dart';
import 'package:http/http.dart' as http;

class NoCardsFoundException implements Exception {}

class ScryfallRepository {
  static const _baseUrl = 'https://api.scryfall.com/cards/search';

  Future<CardSearchResponse> searchCards(String query) async {
    final uri = Uri.parse(
      '$_baseUrl?order=name&q=${Uri.encodeQueryComponent(query)}',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      return CardSearchResponse.fromJson(jsonBody);
    }

    if (response.statusCode == 404) {
      throw NoCardsFoundException();
    }

    throw Exception('Scryfall request failed (status ${response.statusCode})');
  }
}
