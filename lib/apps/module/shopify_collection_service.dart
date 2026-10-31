
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShopifyCollectionService {
  static const String storeDomain = 'flutter-developer.myshopify.com';
  static const String apiVersion = '2026-10';
  static const String storefrontToken = 'c71631f99e3257f1f6749095e0682220';
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

  static Future<List<String>> getGalleryImages() async {
    const String query = r'''
    query GetGallery {
      metaobjects(type: "gallery", first: 10) {
        nodes {
          id
          handle

          galleryImages: field(key: "gallery_images") {
            references(first: 50) {
              nodes {
                ... on MediaImage {
                  image {
                    url
                  }
                }
              }
            }
          }
        }
      }
    }
  ''';

    final response = await http.post(
      Uri.parse(
        'https://$storeDomain/api/$apiVersion/graphql.json',
      ),
      headers: {
        'Content-Type': 'application/json',
        'X-Shopify-Storefront-Access-Token': storefrontToken,
      },
      body: jsonEncode({
        'query': query,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gallery API error: ${response.statusCode}',
      );
    }

    final Map<String, dynamic> responseData =
    jsonDecode(response.body);

    if (responseData['errors'] != null) {
      throw Exception(responseData['errors']);
    }

    final List<dynamic> galleries =
    responseData['data']['metaobjects']['nodes'];

    if (galleries.isEmpty) {
      return [];
    }

    final List<dynamic> imageNodes =
        galleries.first['galleryImages']?['references']?['nodes'] ?? [];

    return imageNodes
        .map<String?>(
          (item) => item['image']?['url'] as String?,
    )
        .whereType<String>()
        .toList();
  }

}
