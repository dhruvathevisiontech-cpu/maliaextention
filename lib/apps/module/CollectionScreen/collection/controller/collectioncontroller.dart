import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Collectioncontroller extends GetxController {
  final RxInt selectedCollection = (-1).obs;

  final RxList<Map<String, dynamic>> collections = <Map<String, dynamic>>[].obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<Map<String, dynamic>> metaobjectCollections = <Map<String, dynamic>>[].obs;

  final RxBool isMetaobjectsLoading = false.obs;

  final RxString metaobjectsErrorMessage = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchCollectionMetaobjects();

  }
  Future<void> fetchCollectionMetaobjects() async {
    try {
      isMetaobjectsLoading.value = true;
      metaobjectsErrorMessage.value = '';

      final uri = Uri.https(
        ShopifyCollectionService.storeDomain,
        '/api/${ShopifyCollectionService.apiVersion}/graphql.json',
      );

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'X-Shopify-Storefront-Access-Token':
          ShopifyCollectionService.storefrontToken,
        },
        body: jsonEncode({
          'query': r'''
          query GetCollectionMetaobjects {
            metaobjects(type: "collection", first: 50) {
              nodes {
                id
                handle
                fields {
                  key
                  value
                  reference {
                    __typename
                    ... on Collection {
                      id
                      title
                      handle
                      image {
                        url
                        altText
                      }
                    }
                    ... on MediaImage {
                      image {
                        url
                        altText
                      }
                    }
                    ... on GenericFile {
                      url
                    }
                  }
                }
              }
            }
          }
        ''',
        }),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'HTTP ${response.statusCode}: ${response.body}',
        );
      }

      final decoded =
      jsonDecode(response.body) as Map<String, dynamic>;

      if (decoded['errors'] != null) {
        throw Exception('GraphQL errors: ${decoded['errors']}');
      }

      final data = decoded['data'] as Map<String, dynamic>?;
      final nodes =
          data?['metaobjects']?['nodes'] as List? ?? [];
      print('Metaobject nodes received: ${nodes.length}');

      for (final item in nodes) {
        final node = item as Map<String, dynamic>;

        print('Entry handle: ${node['handle']}');

        final fields = node['fields'] as List? ?? [];

        for (final field in fields) {
          final entry = field as Map<String, dynamic>;

          print(
            'FIELD: ${entry['key']} '
                '| VALUE: ${entry['value']} '
                '| REFERENCE: ${entry['reference']}',
          );
        }
      }

      final result = <Map<String, dynamic>>[];

      for (final item in nodes) {
        final node = item as Map<String, dynamic>;
        final fields = node['fields'] as List? ?? [];
        final values = <String, dynamic>{};

        for (final field in fields) {
          final entry = field as Map<String, dynamic>;
          final key = entry['key']?.toString() ?? '';
          final value = entry['value'];
          final reference =
          entry['reference'] as Map<String, dynamic>?;

          values[key] = value;

          if (key == 'collection' && reference != null) {
            values['collectionId'] = reference['id'];
            values['collectionTitle'] = reference['title'];
            values['collectionHandle'] = reference['handle'];

            final collectionImage =
            reference['image'] as Map<String, dynamic>?;
            if (collectionImage?['url'] != null) {
              values['collectionImageUrl'] =
              collectionImage!['url'];
            }
          }

          if (key == 'image' && reference != null) {
            final mediaImage =
            reference['image'] as Map<String, dynamic>?;

            values['imageUrl'] =
                mediaImage?['url'] ?? reference['url'];
          }
        }

        final activeValue =
        values['is_active']?.toString().toLowerCase();

        print('Metaobject is_active: $activeValue');

        // Skip inactive entries. Empty values are not treated as active.
        if (activeValue != 'true') continue;

        final title =
            values['title']?.toString().trim() ?? '';

        result.add({
          'id': node['id'] ?? '',
          'handle': node['handle'] ?? '',
          'title': title.isNotEmpty
              ? title
              : (values['collectionTitle'] ??
              node['handle'] ??
              ''),
          'collectionId': values['collectionId'],
          'collectionTitle': values['collectionTitle'],
          'collectionHandle': values['collectionHandle'],
          'imageUrl': values['imageUrl'] ??
              values['collectionImageUrl'],
          'sortOrder':
          int.tryParse('${values['sort_order'] ?? ''}') ?? 9999,
        });
      }

      result.sort(
            (a, b) => (a['sortOrder'] as int)
            .compareTo(b['sortOrder'] as int),
      );

      metaobjectCollections.assignAll(result);

      print('Active metaobjects: ${result.length}');
      for (final item in result) {
        print(
          '${item['title']} | '
              'collection: ${item['collectionHandle']} | '
              'image: ${item['imageUrl']}',
        );
      }
    } catch (e, stackTrace) {
      metaobjectsErrorMessage.value = e.toString();
      print('Metaobjects error: $e');
      print(stackTrace);
    } finally {
      isMetaobjectsLoading.value = false;
    }
  }

}
