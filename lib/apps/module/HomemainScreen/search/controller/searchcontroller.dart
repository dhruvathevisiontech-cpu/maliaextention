
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Searchdatacontroller extends GetxController {
  final TextEditingController searchTextController =
  TextEditingController();

  final RxString searchText = ''.obs;

  final RxList<Map<String, String>> products =
      <Map<String, String>>[].obs;

  final RxList<Map<String, String>> collections =
      <Map<String, String>>[].obs;

  final RxList<String> suggestions = <String>[].obs;
  final RxList<String> recentSearches = <String>[].obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Worker? _searchWorker;
  int _requestId = 0;

  static const String _searchQuery = r'''
  query SearchProductsAndCollections($query: String!) {
    products(first: 6, query: $query) {
      nodes {
        id
        title
        handle
        featuredImage {
          url
        }
      }
    }

    collections(first: 6, query: $query) {
      nodes {
        id
        title
        handle
        image {
          url
        }
      }
    }

    predictiveSearch(
      query: $query
      limit: 10
      types: [PRODUCT, COLLECTION, QUERY]
    ) {
      queries {
        text
      }

      products {
        id
        title
        handle
        featuredImage {
          url
        }
      }

      collections {
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

  @override
  void onInit() {
    super.onInit();

    _searchWorker = debounce<String>(
      searchText,
          (value) {
        if (value.trim().isEmpty) {
          _requestId++;
          products.clear();
          collections.clear();
          suggestions.clear();
          errorMessage.value = '';
          isLoading.value = false;
          return;
        }

        searchProducts(value);
      },
      time: const Duration(milliseconds: 450),
    );
  }

  void onSearchChanged(String value) {
    searchText.value = value;
  }

  Future<void> submitSearch([String? value]) async {
    final term = (value ?? searchTextController.text).trim();

    if (term.isEmpty) {
      clearSearch();
      return;
    }

    searchTextController.text = term;
    searchText.value = term;

    await searchProducts(term);
  }

  void selectRecentSearch(String term) {
    searchTextController.text = term;
    searchText.value = term;
    submitSearch(term);
  }

  void selectSuggestion(String term) {
    searchTextController.text = term;
    searchText.value = term;
    submitSearch(term);
  }

  Future<void> searchProducts([String? value]) async {
    final term = (value ?? searchText.value).trim();

    if (term.isEmpty) return;

    final requestId = ++_requestId;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final data = await ShopifyCollectionService.query(
        _searchQuery,
        variables: {'query': term},
      );

      // Ignore results from an older search request.
      if (requestId != _requestId) return;

      final productNodes =
          data['products']?['nodes'] as List? ?? [];

      final collectionNodes =
          data['collections']?['nodes'] as List? ?? [];

      final predictive = data['predictiveSearch'];

      final predictiveProducts =
          predictive?['products'] as List? ?? [];

      final predictiveCollections =
          predictive?['collections'] as List? ?? [];

      final queryNodes =
          predictive?['queries'] as List? ?? [];

      final productResults = <Map<String, String>>[];
      final seenProductIds = <String>{};

      // Keep the main product search results first.
      for (final node in productNodes) {
        if (node is! Map) continue;

        final product = _mapProduct(node);
        final id = product['id'] ?? '';

        if (id.isNotEmpty && seenProductIds.add(id)) {
          productResults.add(product);
        }
      }

      // Include predictive products without duplicating products.
      for (final node in predictiveProducts) {
        if (node is! Map) continue;

        final product = _mapProduct(node);
        final id = product['id'] ?? '';

        if (id.isNotEmpty && seenProductIds.add(id)) {
          productResults.add(product);
        }
      }

      final collectionResults = <Map<String, String>>[];
      final seenCollectionIds = <String>{};

      for (final node in [
        ...collectionNodes,
        ...predictiveCollections,
      ]) {
        if (node is! Map) continue;

        final collection = _mapCollection(node);
        final id = collection['id'] ?? '';

        if (id.isNotEmpty && seenCollectionIds.add(id)) {
          collectionResults.add(collection);
        }
      }

      final suggestionResults = <String>[];
      final seenSuggestions = <String>{};

      for (final node in queryNodes) {
        if (node is! Map) continue;

        final text = node['text']?.toString().trim() ?? '';

        if (text.isNotEmpty &&
            text.toLowerCase() != term.toLowerCase() &&
            seenSuggestions.add(text.toLowerCase())) {
          suggestionResults.add(text);
        }
      }

      products.assignAll(productResults.take(6));
      collections.assignAll(collectionResults.take(4));
      suggestions.assignAll(suggestionResults.take(6));

      _addRecentSearch(term);

      debugPrint('Search term: $term');
      debugPrint('Products: ${products.length}');
      debugPrint('Collections: ${collections.length}');
      debugPrint('Suggestions: ${suggestions.length}');
    } catch (e, stackTrace) {
      if (requestId != _requestId) return;

      errorMessage.value =
      'Unable to search right now. Please try again.';

      debugPrint('searchProducts error: $e');
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      if (requestId == _requestId) {
        isLoading.value = false;
      }
    }
  }

  Map<String, String> _mapProduct(Map node) {
    final image = node['featuredImage'];

    return {
      'id': node['id']?.toString() ?? '',
      'name': node['title']?.toString() ?? '',
      'handle': node['handle']?.toString() ?? '',
      'image': image is Map
          ? image['url']?.toString() ?? ''
          : '',
      // Do not expose prices in the search preview.
      'price': '',
      'priceLabel': 'Login to See Price',
      'rating': '',
    };
  }

  Map<String, String> _mapCollection(Map node) {
    final image = node['image'];

    return {
      'id': node['id']?.toString() ?? '',
      'name': node['title']?.toString() ?? '',
      'handle': node['handle']?.toString() ?? '',
      'image': image is Map
          ? image['url']?.toString() ?? ''
          : '',
    };
  }

  void _addRecentSearch(String term) {
    final normalized = term.trim();
    if (normalized.isEmpty) return;

    recentSearches.removeWhere(
          (item) => item.toLowerCase() == normalized.toLowerCase(),
    );

    recentSearches.insert(0, normalized);

    if (recentSearches.length > 10) {
      recentSearches.removeRange(10, recentSearches.length);
    }
  }

  void clearSearch() {
    _requestId++;
    searchTextController.clear();
    searchText.value = '';
    products.clear();
    collections.clear();
    suggestions.clear();
    errorMessage.value = '';
    isLoading.value = false;
  }

  @override
  void onClose() {
    _searchWorker?.dispose();
    searchTextController.dispose();
    super.onClose();
  }
}
