
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:maliaextention/apps/module/shopify_collection_service.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/apps/module/WishlistScreen/wishlist/controller/wishlistcontroller.dart';
import 'package:maliaextention/typo/appsnackbar.dart';

class Collectionlistcontroller extends GetxController {
  final RxInt selectedSubCollection = 0.obs;
  final RxList<Map<String, dynamic>> metaobjectCollections = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> subCollections = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, String>> products = <Map<String, String>>[].obs;
  final RxList<Map<String, String>> allProducts = <Map<String, String>>[].obs;
  final RxBool isLoadingCollections = false.obs;
  final RxBool isLoadingSubCollections = false.obs;
  final RxBool isLoadingProducts = false.obs;
  final RxString errorMessage = ''.obs;
  final RxSet<String> appliedSortBy = <String>{'featured'}.obs;
  final RxSet<String> appliedAvailability = <String>{}.obs;
  final RxSet<String> appliedCollections = <String>{}.obs;
  final RxSet<String> appliedLength = <String>{}.obs;
  final Wishlistcontroller wishlistController = Get.find<Wishlistcontroller>();
  bool _isLoadingParentProducts = false;
  bool _hasLoadedParentProducts = false;
  String? _loadedParentId;
  String? _loadedSubCollectionId;

  static const String _metaobjectsQuery = r'''
    query GetCollectionMetaobjects {
      metaobjects(type: "collection", first: 50) {
        nodes {
          id
          handle
          fields {
            key
            value
            reference {
              ... on Collection {
                id
                title
                handle
                image {
                  url
                }
              }
              ... on MediaImage {
                image {
                  url
                }
              }
              ... on Product {
                id
                title
                handle
              }
            }
            references(first: 50) {
              nodes {
                ... on Collection {
                  id
                  title
                  handle
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

  static const String _productsQuery = r'''
  query GetCollectionProducts($handle: String!) {
    collection(handle: $handle) {
      id
      title
      handle
      products(first: 50) {
        nodes {
          id
          title
          handle
          availableForSale
          createdAt
          collections(first: 50) {
            nodes {
              handle
            }
          }
          featuredImage {
            url
          }
          images(first: 1) {
            nodes {
              url
            }
          }
          variants(first: 100) {
            nodes {
              availableForSale
              price {
                amount
                currencyCode
              }
              selectedOptions {
                name
                value
              }
            }
          }
        }
      }
    }
  }
''';
  static const String _collectionsByIdsQuery = r'''
  query GetCollectionsByIds($ids: [ID!]!) {
    nodes(ids: $ids) {
      ... on Collection {
        id
        title
        handle
        image {
          url
        }
      }
    }
  }
''';

  Future<List<Map<String, dynamic>>> _loadCollectionsByIds(
      List<String> ids,
      ) async {
    if (ids.isEmpty) return [];

    final data = await _shopifyRequest(
      _collectionsByIdsQuery,
      variables: {'ids': ids},
    );

    final nodes = data['nodes'] as List? ?? [];
    final result = <Map<String, dynamic>>[];

    for (final node in nodes) {
      final collection = _collectionFromReference(node);
      if (collection != null) {
        result.add(collection);
      }
    }

    return result;
  }

  Future<Map<String, dynamic>> _shopifyRequest(
      String query, {
        Map<String, dynamic> variables = const {},
      }) async {
    return await ShopifyCollectionService.query(
      query,
      variables: variables,
    );
  }


  Map<String, dynamic> _fieldsByKey(dynamic rawFields) {
    final result = <String, dynamic>{};

    if (rawFields is! List) return result;

    for (final rawField in rawFields) {
      if (rawField is Map<String, dynamic>) {
        result[rawField['key']?.toString() ?? ''] = rawField;
      }
    }

    return result;
  }

  Map<String, dynamic>? _collectionFromReference(dynamic reference) {
    if (reference is! Map<String, dynamic>) return null;

    final id = reference['id']?.toString() ?? '';
    final handle = reference['handle']?.toString() ?? '';

    if (id.isEmpty || handle.isEmpty) return null;

    return {
      'id': id,
      'title': reference['title']?.toString() ?? '',
      'handle': handle,
      'image': reference['image'] is Map
          ? (reference['image']['url']?.toString() ?? '')
          : '',
    };
  }

  Future<void> loadMetaobjectCollections() async {
    isLoadingCollections.value = true;
    errorMessage.value = '';
    try {
      final data = await _shopifyRequest(_metaobjectsQuery);
      final nodes = data['metaobjects']?['nodes'] as List? ?? [];
      final loaded = <Map<String, dynamic>>[];
      for (final item in nodes) {
        if (item is! Map<String, dynamic>) continue;
        final fields = _fieldsByKey(item['fields']);
        final titleField = fields['title'];
        final activeField = fields['is_active'];
        final sortField = fields['sort_order'];
        final collectionField = fields['collection'];
        final imageField = fields['image'];
        final subcollectionsField = fields['subcollections'] ?? fields['Subcollections'];
        final activeValue = activeField?['value']?.toString().toLowerCase().trim();
        if (activeValue == 'false') continue;
        final linkedCollection = _collectionFromReference(collectionField?['reference']);
        final imageReference = imageField?['reference'];
        String imageUrl = '';
        if (imageReference is Map<String, dynamic>) {
          final image = imageReference['image'];
          if (image is Map) {
            imageUrl = image['url']?.toString() ?? '';
          } else {
            imageUrl = imageReference['url']?.toString() ?? '';
          }
        }
        final referenceNodes = subcollectionsField?['references']?['nodes'] as List? ?? [];
        final children = <Map<String, dynamic>>[];
        for (final child in referenceNodes) {
          final parsed = _collectionFromReference(child);
          if (parsed != null) {
            children.add(parsed);
          }
        }
        if (children.isEmpty) {
          final rawValue = subcollectionsField?['value']?.toString().trim() ?? '';
          if (rawValue.isNotEmpty) {
            try {
              final decoded = jsonDecode(rawValue);
              if (decoded is List) {
                final ids = decoded
                    .map((id) => id.toString().trim())
                    .where((id) => id.startsWith('gid://shopify/Collection/'))
                    .toList();
                children.addAll(await _loadCollectionsByIds(ids));
              }
            } catch (e) {
            }
          }
        }
        loaded.add({
          'id': item['id']?.toString() ?? '',
          'handle': item['handle']?.toString() ?? '',
          'title': titleField?['value']?.toString().trim().isNotEmpty == true
              ? titleField!['value'].toString().trim()
              : linkedCollection?['title'] ?? '',
          'sort_order':
          int.tryParse(sortField?['value']?.toString() ?? '') ?? 9999,
          'collection': linkedCollection,
          'image': imageUrl.isNotEmpty
              ? imageUrl
              : linkedCollection?['image'] ?? '',
          'subcollections': children,
        });
      }
      loaded.sort(
            (a, b) => (a['sort_order'] as int).compareTo(
          b['sort_order'] as int,
        ),
      );
      metaobjectCollections.assignAll(loaded);
    } catch (e, stackTrace) {
      errorMessage.value = 'Unable to load collections.';
    } finally {
      isLoadingCollections.value = false;
    }
  }
  Future<void> loadSubCollectionsForParent(String parentTitle) async {
    final parent = metaobjectCollections.firstWhereOrNull(
          (item) =>
      item['title'].toString().trim().toLowerCase() ==
          parentTitle.trim().toLowerCase(),
    );

    if (parent == null) {
      allProducts.clear();
      products.clear();
      errorMessage.value = 'No matching collection found.';
      return;
    }

    final parentId = parent['id']?.toString() ?? '';

    // Prevent repeated API calls.
    if (_loadedParentId == parentId &&
        (_isLoadingParentProducts || _hasLoadedParentProducts)) {
      return;
    }

    _loadedParentId = parentId;
    _hasLoadedParentProducts = false;

    allProducts.clear();
    products.clear();

    _isLoadingParentProducts = true;
    isLoadingProducts.value = true;
    errorMessage.value = '';

    try {
      final collection = parent['collection'];

      final handle = collection is Map
          ? collection['handle']?.toString() ?? ''
          : '';

      if (handle.isEmpty) {
        errorMessage.value = 'Shopify collection handle is missing.';
        return;
      }

      final data = await _shopifyRequest(
        _productsQuery,
        variables: {'handle': handle},
      );

      final collectionData = data['collection'];

      if (collectionData == null) {
        errorMessage.value = 'Shopify collection not found.';
        return;
      }

      final nodes =
          collectionData['products']?['nodes'] as List? ?? [];

      final loadedProducts = <Map<String, String>>[];

      for (final node in nodes) {
        if (node is! Map<String, dynamic>) continue;

        final imageUrl =
            node['featuredImage']?['url']?.toString() ?? '';

        final variants =
            node['variants']?['nodes'] as List? ?? [];

        String price = '';
        final lengthValues = <String>[];
        final variantAvailability = <String>[];

        for (final variant in variants) {
          if (variant is! Map<String, dynamic>) continue;

          final priceData = variant['price'];

          if (price.isEmpty && priceData is Map<String, dynamic>) {
            price = priceData['amount']?.toString() ?? '';
          }

          variantAvailability.add(
            variant['availableForSale'] == true ? 'true' : 'false',
          );

          final options =
              variant['selectedOptions'] as List? ?? [];

          for (final option in options) {
            if (option is! Map<String, dynamic>) continue;

            final optionName =
                option['name']?.toString().toLowerCase() ?? '';

            final optionValue =
                option['value']?.toString() ?? '';

            if (optionName.contains('length') &&
                optionValue.isNotEmpty) {
              lengthValues.add(optionValue);
            }
          }
        }

        final collectionNodes =
            node['collections']?['nodes'] as List? ?? [];

        final collectionHandles = collectionNodes
            .whereType<Map>()
            .map((item) => item['handle']?.toString() ?? '')
            .where((handle) => handle.isNotEmpty)
            .toSet()
            .toList();

        loadedProducts.add({
          'id': node['id']?.toString() ?? '',
          'name': node['title']?.toString() ?? '',
          'handle': node['handle']?.toString() ?? '',
          'image': imageUrl,
          'rating': '',
          'price': price,
          '_availableForSale':
          node['availableForSale'] == true ? 'true' : 'false',
          '_collectionHandles': jsonEncode(collectionHandles),
          '_lengthOptions': jsonEncode(lengthValues.toSet().toList()),
          '_variantAvailability': jsonEncode(variantAvailability),
          '_createdAt': node['createdAt']?.toString() ?? '',
        });
      }

      allProducts.assignAll(loadedProducts);

      applyProductFilters();

      _hasLoadedParentProducts = true;

    } catch (e, stackTrace) {
      debugPrint('PARENT PRODUCTS ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);

      errorMessage.value = 'Unable to load products.';

      // Allow retry after an API failure.
      _loadedParentId = null;
    } finally {
      _isLoadingParentProducts = false;
      isLoadingProducts.value = false;
    }
  }
  Future<void> selectSubCollection(int index) async {
    if (index < 0 || index >= subCollections.length) return;

    selectedSubCollection.value = index;
    await loadProductsForSelectedSubCollection(index);
  }


  Future<void> loadProductsForSelectedSubCollection(int index) async {
    if (index < 0 || index >= subCollections.length) {
      allProducts.clear();
      products.clear();
      return;
    }

    final selected = subCollections[index];
    final handle = selected['handle']?.toString() ?? '';
    final selectedId = selected['id']?.toString();

    if (handle.isEmpty) {
      allProducts.clear();
      products.clear();
      errorMessage.value =
      'The selected Shopify collection has no handle.';
      return;
    }

    // Reuse the cached products when switching back to a loaded collection.
    if (_loadedSubCollectionId == selectedId &&
        allProducts.isNotEmpty) {
      applyProductFilters();
      return;
    }

    _loadedSubCollectionId = selectedId;
    isLoadingProducts.value = true;
    errorMessage.value = '';
    allProducts.clear();
    products.clear();

    try {
      final data = await _shopifyRequest(
        _productsQuery,
        variables: {'handle': handle},
      );

      final collection = data['collection'];

      if (collection == null) {
        errorMessage.value = 'This Shopify collection was not found.';
        return;
      }

      final nodes = collection['products']?['nodes'] as List? ?? [];
      final loadedProducts = <Map<String, String>>[];

      for (final node in nodes) {
        if (node is! Map<String, dynamic>) continue;

        final imageUrl =
            node['featuredImage']?['url']?.toString() ??
                ((node['images']?['nodes'] as List?)?.isNotEmpty == true
                    ? node['images']['nodes'][0]['url']?.toString() ?? ''
                    : '');

        final variants = node['variants']?['nodes'] as List? ?? [];

        String price = '';
        final lengthValues = <String>[];
        final variantAvailability = <String>[];

        for (final variant in variants) {
          if (variant is! Map<String, dynamic>) continue;

          final priceData = variant['price'];

          // Preserve the existing first-variant price behavior.
          if (price.isEmpty && priceData is Map<String, dynamic>) {
            price = priceData['amount']?.toString() ?? '';
          }

          variantAvailability.add(
            variant['availableForSale'] == true ? 'true' : 'false',
          );

          final options = variant['selectedOptions'] as List? ?? [];

          for (final option in options) {
            if (option is! Map<String, dynamic>) continue;

            final optionName =
                option['name']?.toString().toLowerCase() ?? '';
            final optionValue = option['value']?.toString() ?? '';

            if (optionName.contains('length') &&
                optionValue.isNotEmpty) {
              lengthValues.add(optionValue);
            }
          }
        }

        final collectionNodes =
            node['collections']?['nodes'] as List? ?? [];

        final collectionHandles = collectionNodes
            .whereType<Map>()
            .map((item) => item['handle']?.toString() ?? '')
            .where((handle) => handle.isNotEmpty)
            .toSet()
            .toList();

        loadedProducts.add({
          'id': node['id']?.toString() ?? '',
          'name': node['title']?.toString() ?? '',
          'handle': node['handle']?.toString() ?? '',
          'image': imageUrl,
          'rating': '',
          'price': price,
          '_availableForSale': node['availableForSale'] == true ? 'true' : 'false',
          '_collectionHandles': jsonEncode(collectionHandles),
          '_lengthOptions': jsonEncode(lengthValues.toSet().toList()),
          '_variantAvailability': jsonEncode(variantAvailability),
          '_createdAt': node['createdAt']?.toString() ?? '',
        });
      }
      allProducts.assignAll(loadedProducts);
      applyProductFilters();
    } catch (e, stackTrace) {
      errorMessage.value = 'Unable to load products.';
    } finally {
      isLoadingProducts.value = false;
    }
  }

  String _normalizeFilterValue(String value) {
    return value
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[^a-z0-9]'), '');
  }

  bool _matchesLength(String selected, List<dynamic> productLengths) {
    final selectedNormalized = _normalizeFilterValue(selected);

    for (final rawLength in productLengths) {
      final value = rawLength.toString();
      final normalized = _normalizeFilterValue(value);

      if (selectedNormalized == normalized) {
        return true;
      }

      // For IDs such as 16_inch or 16_50g, compare the
      // leading length number with Shopify's length option value.
      final selectedNumber =
      RegExp(r'^\d+').firstMatch(selected)?.group(0);
      final productNumber =
      RegExp(r'^\d+').firstMatch(value)?.group(0);

      if (selectedNumber != null &&
          productNumber != null &&
          selectedNumber == productNumber) {
        return true;
      }
    }

    return false;
  }

  void applyProductFilters() {
    List<Map<String, String>> result =
    List<Map<String, String>>.from(allProducts);

    // 1. Availability filter.
    final availability = appliedAvailability.toSet();

    if (availability.contains('in_stock') &&
        !availability.contains('out_of_stock')) {
      result = result.where((product) {
        return product['_availableForSale'] == 'true';
      }).toList();
    } else if (availability.contains('out_of_stock') &&
        !availability.contains('in_stock')) {
      result = result.where((product) {
        return product['_availableForSale'] != 'true';
      }).toList();
    }

    // 2. Collection filter.
    // Selected IDs can use underscores while Shopify handles use hyphens.
    if (appliedCollections.isNotEmpty) {
      result = result.where((product) {
        List<dynamic> handles = [];

        try {
          final decoded = jsonDecode(
            product['_collectionHandles'] ?? '[]',
          );
          if (decoded is List) handles = decoded;
        } catch (_) {}

        return appliedCollections.any((selected) {
          final selectedNormalized = _normalizeFilterValue(selected);

          return handles.any((handle) {
            return _normalizeFilterValue(handle.toString()) ==
                selectedNormalized;
          });
        });
      }).toList();
    }

    // 3. Length filter.
    if (appliedLength.isNotEmpty) {
      result = result.where((product) {
        List<dynamic> lengths = [];

        try {
          final decoded = jsonDecode(
            product['_lengthOptions'] ?? '[]',
          );
          if (decoded is List) lengths = decoded;
        } catch (_) {}

        return appliedLength.any(
              (selected) => _matchesLength(selected, lengths),
        );
      }).toList();
    }

    // 4. Sort the remaining products.
    final sortBy = appliedSortBy.isNotEmpty
        ? appliedSortBy.first
        : 'featured';

    switch (sortBy) {
      case 'alpha_asc':
        result.sort((a, b) =>
            (a['name'] ?? '').toLowerCase().compareTo(
              (b['name'] ?? '').toLowerCase(),
            ));
        break;

      case 'alpha_desc':
        result.sort((a, b) =>
            (b['name'] ?? '').toLowerCase().compareTo(
              (a['name'] ?? '').toLowerCase(),
            ));
        break;

      case 'price_asc':
        result.sort((a, b) =>
            (double.tryParse(a['price'] ?? '') ?? 0)
                .compareTo(double.tryParse(b['price'] ?? '') ?? 0));
        break;

      case 'price_desc':
        result.sort((a, b) =>
            (double.tryParse(b['price'] ?? '') ?? 0)
                .compareTo(double.tryParse(a['price'] ?? '') ?? 0));
        break;

      case 'date_old_new':
        result.sort((a, b) =>
            (a['_createdAt'] ?? '').compareTo(b['_createdAt'] ?? ''));
        break;

      case 'date_new_old':
        result.sort((a, b) =>
            (b['_createdAt'] ?? '').compareTo(a['_createdAt'] ?? ''));
        break;
      case 'featured':
      case 'relevant':
      case 'best_selling':
      default:
        break;
    }
    products.assignAll(result);
  }
  bool isWishlisted(Map<String, String> product) {
    final id = product['id'] ?? '';
    if (id.isEmpty) return false;
    return wishlistController.isWishlisted(id);
  }
  void toggleWishlist(Map<String, String> product) {
    final productId = product['id'] ?? '';
    if (productId.isEmpty) {
      AppSnackbar.error('Product ID is missing.',);
      return;
    }

    _showWishlistPicker(product);
  }

  void _showWishlistPicker(Map<String, String> product) {
    final productId = product['id'] ?? '';
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        decoration: BoxDecoration(
          color: Colorstheam.white,
        ),
        child: SafeArea(
          child: Obx(() {
            final wishlists = wishlistController.wishlists.toList();

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Save to wishlist',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Choose a collection for this product.',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 13,
                    color: Colorstheam.grey,
                  ),
                ),
                const SizedBox(height: 18),

                if (wishlists.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'No wishlist collections yet. Create one first.',
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 14,
                        color: Colorstheam.grey,
                      ),
                    ),
                  )
                else
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: wishlists.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        final wishlist = wishlists[index];
                        final id = wishlist['id']?.toString() ?? '';
                        final name =
                            wishlist['name']?.toString() ?? 'Wishlist';

                        final rawProducts = wishlist['products'];
                        final count = rawProducts is List
                            ? rawProducts.length
                            : 0;

                        final alreadyAdded =
                        wishlistController.isProductInWishlist(
                          id,
                          productId,
                        );

                        return Material(
                          color: Colorstheam.white,
                          child: ListTile(
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 4),
                            title: Text(
                              name,
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                            subtitle: Text(
                              '$count ${count == 1 ? 'item' : 'items'}',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 12,
                                color: Colorstheam.grey,
                              ),
                            ),
                            trailing: Icon(
                              alreadyAdded
                                  ? Icons.check_circle
                                  : Icons.add_circle_outline,
                              color: Colorstheam.nobelblack,
                            ),
                            onTap: () {
                              if (alreadyAdded) {
                                Get.back();
                                AppSnackbar.error('This product is already in "$name".',);
                                return;
                              }

                              wishlistController.addProductToWishlist(
                                id,
                                Map<String, dynamic>.from(product),
                              );

                              Get.back();

                              AppSnackbar.success('Added to "$name".',);
                            },
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
  @override
  void onInit() {
    super.onInit();
    loadMetaobjectCollections();
  }
}
