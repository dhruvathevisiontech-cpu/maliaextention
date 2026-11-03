
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Homecontroller extends GetxController {
  final ScrollController homeScrollController = ScrollController();
  final RxMap<String, dynamic> homeContent = <String, dynamic>{}.obs;
  final RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> featuredProducts = <Map<String, dynamic>>[].obs;
  final RxList<String> lengthOptions = <String>[].obs;
  final RxBool isHomeLoading = false.obs;
  final RxString homeErrorMessage = ''.obs;
  final RxString selectedLength = '14'.obs;
  final RxInt selectedEducation = 0.obs;
  void selectLength(String length) {
    selectedLength.value = length;
  }
  void selectEducation(int index) {
    selectedEducation.value = index;
  }
  final RxSet<int> wishlistItems = <int>{}.obs;
  void toggleWishlist(int index) {
    if (wishlistItems.contains(index)) {
      wishlistItems.remove(index);
    } else {
      wishlistItems.add(index);
    }
  }
  bool isWishlisted(int index) {
    return wishlistItems.contains(index);
  }
  late VideoPlayerController butterflyVideoController;
  final RxBool isButterflyVideoInitialized = false.obs;
  static const String _homePageQuery = r'''
    query GetHomePage {
      metaobjects(type: "home_page", first: 10) {
        nodes {
          id
          handle
          fields {
            key
            value
            reference {
              ... on MediaImage {
                image {
                  url
                }
              }
              ... on Collection {
                id
                title
                handle
              }
            }
            references(first: 20) {
              nodes {
                ... on MediaImage {
                  image {
                    url
                  }
                }
                ... on Collection {
                  id
                  title
                  handle
                }
              }
            }
          }
        }
      }
    }
  ''';
  static const String _categoriesQuery = r'''
  query GetCollectionCategories {
    metaobjects(type: "collection", first: 50) {
      nodes {
        id
        handle
        fields {
          key
          value
          reference {
            ... on MediaImage {
              image {
                url
              }
            }
            ... on Collection {
              id
              title
              handle
            }
          }
        }
      }
    }
  }
''';
  @override
  void onInit() {
    super.onInit();
    butterflyVideoController = VideoPlayerController.asset(
      'asset/video/video1.mp4',
    );
    butterflyVideoController.initialize().then((_) {
      isButterflyVideoInitialized.value = true;
    }).catchError((error) {
    });
    fetchHomePage();
  }
  Future<void> fetchHomePage() async {
    if (isHomeLoading.value) return;
    isHomeLoading.value = true;
    homeErrorMessage.value = '';
    try {
      final data = await ShopifyCollectionService.query(
        _homePageQuery,
      );
      final entries = data['metaobjects']?['nodes'] as List? ?? [];
      Map<String, dynamic>? activeEntry;
      for (final entry in entries) {
        final fields = entry['fields'] as List? ?? [];
        final fieldMap = <String, dynamic>{};
        for (final field in fields) {
          fieldMap[field['key'].toString()] = field;
        }
        final isActive = fieldMap['is_active']?['value']
            ?.toString()
            .toLowerCase() ==
            'true';
        if (isActive) {
          activeEntry = {
            'id': entry['id'],
            'handle': entry['handle'],
            'fields': fieldMap,
          };
          break;
        }
      }
      if (activeEntry == null) {
        throw Exception(
          'No active home_page entry found. '
              'Check the is_active field and Storefront API access.',
        );
      }
      final fields = activeEntry['fields'] as Map<String, dynamic>;
      dynamic fieldValue(String key) {
        return fields[key]?['value'];
      }
      Map<String, dynamic>? fieldReference(String key) {
        final value = fields[key]?['reference'];
        return value is Map
            ? Map<String, dynamic>.from(value)
            : null;
      }

      List<dynamic> fieldReferences(String key) {
        return fields[key]?['references']?['nodes'] as List? ??
            [];
      }

      String imageUrlFromReference(dynamic reference) {
        if (reference is! Map) return '';

        final image = reference['image'];
        if (image is Map) {
          return image['url']?.toString() ?? '';
        }

        return '';
      }

      String imageUrl(String key) {
        return imageUrlFromReference(
          fieldReference(key),
        );
      }

      List<String> textList(String key) {
        final rawValue = fieldValue(key);

        if (rawValue == null || rawValue.toString().isEmpty) {
          return [];
        }

        try {
          final decoded = jsonDecode(rawValue.toString());

          if (decoded is List) {
            return decoded
                .map((item) => item.toString())
                .toList();
          }
        } catch (_) {
        }

        return [rawValue.toString()];
      }

      homeContent.assignAll({
        'id': activeEntry['id'],
        'handle': activeEntry['handle'],
        'hero_image': imageUrl('hero_image'),
        'hero_eyebrow': fieldValue('hero_eyebrow') ?? '',
        'hero_title': fieldValue('hero_title') ?? '',
        'hero_description': fieldValue('hero_description') ?? '',
        'hero_button_label': fieldValue('hero_button_label') ?? '',
        'hero_button_link': fieldValue('hero_button_link') ?? '',
        'education_image': imageUrl('education_image'),
        'best_seller_title': fieldValue('best_seller_title') ?? '',
        'shop_by_category_title': fieldValue('shop_by_category_title') ?? '',
        'shop_by_length_title': fieldValue('shop_by_length_title') ?? '',
        'education_title': fieldValue('education_title') ?? '',
        'education_description': fieldValue('education_description') ?? '',
        'in_person_button_label': fieldValue('in_person_button_label') ?? '',
        'in_person_button_link': fieldValue('in_person_button_link') ?? '',
        'online_button_label': fieldValue('online_button_label') ?? '',
        'online_button_link': fieldValue('online_button_link') ?? '',
        'featured_collection': fieldReference('featured_collection'),
      });
      final categoryData = await ShopifyCollectionService.query(
        _categoriesQuery,
      );
      final categoryEntries = categoryData['metaobjects']?['nodes'] as List? ?? [];
      final List<Map<String, dynamic>> activeCategories = [];
      for (final entry in categoryEntries) {
        final entryFields = entry['fields'] as List? ?? [];
        final fieldMap = <String, dynamic>{};
        for (final field in entryFields) {
          fieldMap[field['key'].toString()] = field;
        }
        final isActive = fieldMap['is_active']?['value']?.toString().toLowerCase() == 'true';
        if (!isActive) continue;
        final title = fieldMap['title']?['value']?.toString().trim() ?? '';
        final imageReference = fieldMap['image']?['reference'];
        final imageData = imageReference is Map ? imageReference['image'] : null;
        final collectionReference = fieldMap['collection']?['reference'];
        final collection = collectionReference is Map ? collectionReference : <String, dynamic>{};
        if (title.isEmpty) continue;
        activeCategories.add({
          'title': title,
          'image': imageData is Map ? imageData['url']?.toString() ?? '' : '',
          'collectionId': collection['id']?.toString() ?? '',
          'collectionTitle': collection['title']?.toString() ?? '',
          'handle': collection['handle']?.toString() ?? '',
        });
      }
      categories.assignAll(activeCategories);
      lengthOptions.assignAll(
        textList('length_options')
            .expand((item) => item.split(','))
            .map((item) => item.trim())
            .where((item) => item.isNotEmpty)
            .toList(),
      );
      if (!lengthOptions.contains(selectedLength.value) &&
          lengthOptions.isNotEmpty) {
        selectedLength.value = lengthOptions.first;
      }
      if (lengthOptions.isNotEmpty &&
          !lengthOptions.contains(selectedLength.value)) {
        selectedLength.value = lengthOptions.first;
      }
      await fetchFeaturedProducts();
    } catch (error, stackTrace) {
      homeErrorMessage.value = error.toString();
    } finally {
      isHomeLoading.value = false;
    }
  }

  Future<void> fetchFeaturedProducts() async {
    final collection =
    homeContent['featured_collection'];
    if (collection is! Map || collection['handle'] == null || collection['handle'].toString().isEmpty) {
      featuredProducts.clear();
      return;
    }
    const productsQuery = r'''
      query GetFeaturedProducts($handle: String!) {
        collection(handle: $handle) {
          id
          title
          products(first: 4) {
            nodes {
              id
              title
              handle
              featuredImage {
                url
              }
              variants(first: 1) {
                nodes {
                  price {
                    amount
                    currencyCode
                  }
                }
              }
            }
          }
        }
      }
    ''';

    try {
      final result = await ShopifyCollectionService.query(
        productsQuery,
        variables: {
          'handle': collection['handle'],
        },
      );
      final collectionData = result['collection'];
      if (collectionData == null) {
        featuredProducts.clear();
        return;
      }
      final nodes = collectionData['products']?['nodes'] as List? ?? [];
      featuredProducts.assignAll(
        nodes.map((node) {
          final image = node['featuredImage'];
          final variants = node['variants']?['nodes'] as List? ?? [];
          final price = variants.isNotEmpty ? variants.first['price'] : null;
          return <String, dynamic>{
            'id': node['id']?.toString() ?? '',
            'name': node['title']?.toString() ?? '',
            'handle': node['handle']?.toString() ?? '',
            'image': image is Map
                ? image['url']?.toString() ?? ''
                : '',
            'price': price?['amount']?.toString() ?? '',
            'currencyCode':
            price?['currencyCode']?.toString() ?? '',
            'rating': '',
          };
        }).toList(),
      );
    } catch (error) {
    }
  }

  @override
  void onClose() {
    homeScrollController.dispose();
    butterflyVideoController.dispose();
    super.onClose();
  }
}
