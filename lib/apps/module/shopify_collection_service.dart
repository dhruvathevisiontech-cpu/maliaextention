import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ShopifyCollectionService {
  //Test
  //static const String storeDomain = 'flutter-developer.myshopify.com';
  //static const String apiVersion = '2026-10';
  //static const String storefrontToken = 'c71631f99e3257f1f6749095e0682220';
  //static String get baseUrl => 'https://$storeDomain/api/$apiVersion/graphql.json';

  //Main Store
  static const String storeDomain = '7b4ae8-00.myshopify.com';
  static const String apiVersion = '2026-10';
  static const String storefrontToken = '0e45c3196b3670a3eea75b07ba09e0e7';
  static String get baseUrl => 'https://$storeDomain/api/$apiVersion/graphql.json';

  static Future<Map<String, dynamic>> query(String query, {Map<String, dynamic> variables = const {}}) async {
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
  static Future<Map<String, dynamic>> queryTokenless(String query, {Map<String, dynamic> variables = const {}}) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
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
    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Invalid Shopify GraphQL response.');
    }
    if (decoded['errors'] != null) {
      throw Exception(
        'Shopify GraphQL errors: ${decoded['errors']}',
      );
    }
    final data = decoded['data'];
    if (data is! Map<String, dynamic>) {
      throw Exception('Shopify returned no GraphQL data.');
    }
    return data;
  }
  static Future<void> testCustomerEmail(String email) async {
    const mutation = r'''
    mutation CustomerRecover($email: String!) {
      customerRecover(email: $email) {
        customerUserErrors {
          field
          message
          code
        }
      }
    }
  ''';

    try {
      final data = await ShopifyCollectionService.query(
        mutation,
        variables: {
          'email': email.trim().toLowerCase(),
        },
      );
      final result = data['customerRecover'];
      final errors = result?['customerUserErrors'] as List<dynamic>? ?? [];
      if (errors.isEmpty) {
        return;
      }
      for (final error in errors) {
        final code = error['code']?.toString();
        if (code == 'UNIDENTIFIED_CUSTOMER') {
        } else {
        }
      }
    } catch (e) {
    }
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
      Uri.parse('https://$storeDomain/api/$apiVersion/graphql.json'),
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
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    if (responseData['errors'] != null) {
      throw Exception(responseData['errors']);
    }
    final List<dynamic> galleries = responseData['data']['metaobjects']['nodes'];
    if (galleries.isEmpty) {
      return [];
    }
    final List<dynamic> imageNodes = galleries.first['galleryImages']?['references']?['nodes'] ?? [];
    return imageNodes.map<String?>((item) => item['image']?['url'] as String?,).whereType<String>().toList();
  }
}