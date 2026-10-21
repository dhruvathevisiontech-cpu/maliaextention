import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/CollectionScreen/collectionlist/controller/collectionlistcontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class FilterCategory {
  final String title;
  final FilterType type;

  FilterCategory({
    required this.title,
    required this.type,
  });
}

enum FilterType {
  sortBy,
  availability,
  collections,
  length,
}

class FilterOption {
  final String id;
  final String label;
  final int? count;

  FilterOption({
    required this.id,
    required this.label,
    this.count,
  });
}

class Filtercontroller extends GetxController {
  // ============================================================
  // SELECTED CATEGORY
  // ============================================================

  final RxInt selectedCategoryIndex = 0.obs;

  final RxInt selectedButton = 1.obs;

  // ============================================================
  // CATEGORIES
  // ============================================================

  final RxList<FilterCategory> categories = <FilterCategory>[
    FilterCategory(title: 'Sort By', type: FilterType.sortBy),
    FilterCategory(title: 'Availability', type: FilterType.availability),
    FilterCategory(title: 'Collections', type: FilterType.collections),
    FilterCategory(title: 'Length', type: FilterType.length),
  ].obs;

  // ============================================================
  // FILTER OPTIONS
  // ============================================================

  final RxMap<FilterType, List<FilterOption>> filterOptions =
      <FilterType, List<FilterOption>>{
        FilterType.sortBy: [
          FilterOption(id: 'featured', label: 'Featured'),
          FilterOption(id: 'relevant', label: 'Most Relevant'),
          FilterOption(id: 'best_selling', label: 'Best Selling'),
          FilterOption(id: 'alpha_asc', label: 'Alphabetically, A–Z'),
          FilterOption(id: 'alpha_desc', label: 'Alphabetically, Z–A'),
          FilterOption(id: 'price_asc', label: 'Price, Low to High'),
          FilterOption(id: 'price_desc', label: 'Price, High to Low'),
          FilterOption(id: 'date_old_new', label: 'Date, Old to New'),
          FilterOption(id: 'date_new_old', label: 'Date, New to Old'),
        ],
        FilterType.availability: [
          FilterOption(id: 'in_stock', label: 'In Stock', count: 0),
          FilterOption(id: 'out_of_stock', label: 'Out Of Stock', count: 0),
        ],
        FilterType.collections: [],
        FilterType.length: [],
      }.obs;

  // ============================================================
  // SELECTED FILTERS
  // ============================================================

  final RxSet<String> selectedSortBy = <String>{
    'featured',
  }.obs;

  final RxSet<String> selectedAvailability = <String>{
    'in_stock',
  }.obs;

  final RxSet<String> selectedCollections = <String>{
    'skinny_butterfly',
  }.obs;

  final RxSet<String> selectedLength = <String>{
    '16_inch',
  }.obs;

  // ============================================================
  // GET SELECTED SET
  // ============================================================

  RxSet<String> getSelectedSet(FilterType type) {
    switch (type) {
      case FilterType.sortBy:
        return selectedSortBy;

      case FilterType.availability:
        return selectedAvailability;

      case FilterType.collections:
        return selectedCollections;

      case FilterType.length:
        return selectedLength;
    }
  }
  static const String _filterQuery = r'''
  query GetDynamicFilters {
  collections(first: 50) {
    nodes {
      id
      title
      handle
    }
  }

  products(first: 100) {
    nodes {
      id
      availableForSale
      collections(first: 50) {
        nodes {
          handle
        }
      }
      variants(first: 100) {
        nodes {
          availableForSale
          selectedOptions {
            name
            value
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
    fetchDynamicFilters();
  }

  Future<void> fetchDynamicFilters() async {
    try {
      final data = await ShopifyCollectionService.query(_filterQuery);

      // Dynamic collections
      // Dynamic collections
      final collectionNodes =
          data['collections']?['nodes'] as List? ?? [];

      final productNodes =
          data['products']?['nodes'] as List? ?? [];

// Count products belonging to each collection.
      final Map<String, Set<String>> collectionProductIds = {};

      for (final product in productNodes) {
        final productId = product['id']?.toString() ?? '';
        final productCollections =
            product['collections']?['nodes'] as List? ?? [];

        for (final collection in productCollections) {
          final handle = collection['handle']?.toString() ?? '';

          if (handle.isEmpty || productId.isEmpty) continue;

          collectionProductIds
              .putIfAbsent(handle, () => <String>{})
              .add(productId);
        }
      }

      final collectionOptions = collectionNodes.map((item) {
        final handle = item['handle']?.toString() ?? '';
        final title = item['title']?.toString() ?? '';

        return FilterOption(
          id: handle,
          label: title,
          count: collectionProductIds[handle]?.length ?? 0,
        );
      }).where((option) {
        return option.id.isNotEmpty && option.label.isNotEmpty;
      }).toList();

      filterOptions[FilterType.collections] = collectionOptions;

      // Dynamic availability and length data

      var inStockCount = 0;
      var outOfStockCount = 0;

      final Map<String, Map<String, dynamic>> lengths = {};

      for (final product in productNodes) {
        final variants =
            product['variants']?['nodes'] as List? ?? [];

        final productAvailable = product['availableForSale'] == true;

        if (productAvailable) {
          inStockCount++;
        } else {
          outOfStockCount++;
        }

        for (final variant in variants) {
          final options =
              variant['selectedOptions'] as List? ?? [];

          String length = '';
          String weight = '';

          for (final option in options) {
            final name =
                option['name']?.toString().toLowerCase() ?? '';
            final value = option['value']?.toString().trim() ?? '';

            if (name.contains('length')) {
              length = value;
            } else if (name.contains('weight')) {
              weight = value;
            }
          }

          if (length.isEmpty) continue;

          final id = length
              .toLowerCase()
              .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
              .replaceAll(RegExp(r'^_|_$'), '');

          final label = [
            length.toUpperCase(),
            if (weight.isNotEmpty) weight,
          ].join(' ');

          lengths.putIfAbsent(id, () => {
            'label': label,
            'count': <String>{},
          });

          (lengths[id]!['count'] as Set<String>)
              .add(product['id']?.toString() ?? '');
        }
      }

      // Update availability counts
      filterOptions[FilterType.availability] = [
        FilterOption(
          id: 'in_stock',
          label: 'In Stock',
          count: inStockCount,
        ),
        FilterOption(
          id: 'out_of_stock',
          label: 'Out Of Stock',
          count: outOfStockCount,
        ),
      ];

      // Update lengths
      filterOptions[FilterType.length] = lengths.entries.map((entry) {
        return FilterOption(
          id: entry.key,
          label: entry.value['label'] as String,
          count: (entry.value['count'] as Set<String>).length,
        );
      }).toList();

      debugPrint('Dynamic collections: ${collectionOptions.length}');
      debugPrint('Dynamic lengths: ${lengths.keys.toList()}');
      debugPrint('In-stock products: $inStockCount');
      debugPrint('Out-of-stock products: $outOfStockCount');
    } catch (error, stackTrace) {
      debugPrint('Failed to fetch dynamic filters: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }
  // ============================================================
  // TOGGLE OPTION
  // ============================================================

  void toggleOption(FilterType type, String id) {
    final selectedSet = getSelectedSet(type);

    if (type == FilterType.sortBy) {
      selectedSet
        ..clear()
        ..add(id);
    } else {
      if (selectedSet.contains(id)) {
        selectedSet.remove(id);
      } else {
        selectedSet.add(id);
      }
    }

    selectedSet.refresh();
  }
  // ============================================================
  // CHECK IF OPTION IS SELECTED
  // ============================================================

  bool isOptionSelected(
      FilterType type,
      String id,
      ) {
    return getSelectedSet(type).contains(id);
  }

  // ============================================================
  // RESET FILTERS
  // ============================================================

  void resetFilters() {
    selectedSortBy.clear();
    selectedAvailability.clear();
    selectedCollections.clear();
    selectedLength.clear();

    selectedButton.value = 0;
  }

  // ============================================================
// APPLY FILTERS
// ============================================================
  void applyFilters() {
    final collectionController =
    Get.find<Collectionlistcontroller>();

    collectionController.appliedSortBy.assignAll(selectedSortBy);
    collectionController.appliedAvailability
        .assignAll(selectedAvailability);
    collectionController.appliedCollections
        .assignAll(selectedCollections);
    collectionController.appliedLength.assignAll(selectedLength);

    // Actually filter the products currently loaded in the list.
    collectionController.applyProductFilters();

    debugPrint('Applied sort: ${selectedSortBy.toList()}');
    debugPrint('Applied availability: ${selectedAvailability.toList()}');
    debugPrint('Applied collections: ${selectedCollections.toList()}');
    debugPrint('Applied lengths: ${selectedLength.toList()}');

    Get.find<Bottomnavigationcontroller>()
        .currentPage
        .value = PageType.collectionlist;
  }
}
