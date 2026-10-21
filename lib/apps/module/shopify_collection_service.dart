
import 'dart:convert';

import 'package:http/http.dart' as http;

class ShopifyCollectionService {
  static const String storeDomain = 'flutter-developer.myshopify.com';
  static const String apiVersion = '2026-10';
  static const String storefrontToken =
      'c71631f99e3257f1f6749095e0682220';

  static String get baseUrl => 'https://$storeDomain/api/$apiVersion/graphql.json';

  static Future<Map<String, dynamic>> query(
      String query, {
        Map<String, dynamic> variables = const {},
      }) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'X-Shopify-Storefront-Access-Token': storefrontToken,
      },
      body: jsonEncode({
        'query': query,
        'variables': variables,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Shopify API failed: ${response.statusCode} ${response.body}',
      );
    }

    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result['errors'] != null) {
      throw Exception('Shopify GraphQL errors: ${result['errors']}');
    }

    return result['data'] as Map<String, dynamic>;
  }
}
