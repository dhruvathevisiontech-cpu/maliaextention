import 'package:get/get.dart';

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

  final List<FilterCategory> categories = [
    FilterCategory(
      title: 'Sort By',
      type: FilterType.sortBy,
    ),
    FilterCategory(
      title: 'Availability',
      type: FilterType.availability,
    ),
    FilterCategory(
      title: 'Collections',
      type: FilterType.collections,
    ),
    FilterCategory(
      title: 'Length',
      type: FilterType.length,
    ),
  ];

  // ============================================================
  // FILTER OPTIONS
  // ============================================================

  final Map<FilterType, List<FilterOption>> filterOptions = {
    FilterType.sortBy: [
      FilterOption(
        id: 'featured',
        label: 'Featured',
      ),
      FilterOption(
        id: 'relevant',
        label: 'Most Relevant',
      ),
      FilterOption(
        id: 'best_selling',
        label: 'Best Selling',
      ),
      FilterOption(
        id: 'alpha_asc',
        label: 'Alphabetically, A–Z',
      ),
      FilterOption(
        id: 'alpha_desc',
        label: 'Alphabetically, Z–A',
      ),
      FilterOption(
        id: 'price_asc',
        label: 'Price, Low to High',
      ),
      FilterOption(
        id: 'price_desc',
        label: 'Price, High to Low',
      ),
      FilterOption(
        id: 'date_old_new',
        label: 'Date, Old to New',
      ),
      FilterOption(
        id: 'date_new_old',
        label: 'Date, New to Old',
      ),
    ],

    FilterType.availability: [
      FilterOption(
        id: 'in_stock',
        label: 'In Stock',
        count: 7,
      ),
      FilterOption(
        id: 'out_of_stock',
        label: 'Out Of Stock',
        count: 5,
      ),
    ],

    FilterType.collections: [
      FilterOption(
        id: 'skinny_butterfly',
        label: 'Skinny Butterfly',
        count: 1,
      ),
      FilterOption(
        id: 'flutter_luxe',
        label: 'Flutter Luxe Butterfly Weft',
        count: 3,
      ),
      FilterOption(
        id: 'butterfly_weft',
        label: 'Butterfly Weft',
        count: 7,
      ),
      FilterOption(
        id: 'genius_wefts',
        label: 'Genius Wefts & K-Tips',
        count: 3,
      ),
    ],

    FilterType.length: [
      FilterOption(
        id: '16_inch',
        label: '16 INCH 50g',
        count: 1,
      ),
      FilterOption(
        id: '18_inch',
        label: '18 INCH 60g',
        count: 1,
      ),
      FilterOption(
        id: '20_inch',
        label: '20 INCH 60g',
        count: 1,
      ),
      FilterOption(
        id: '22_inch',
        label: '22 INCH 70g',
        count: 1,
      ),
      FilterOption(
        id: '24_inch',
        label: '24 INCH 80g',
        count: 1,
      ),
    ],
  };

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

  // ============================================================
  // TOGGLE OPTION
  // ============================================================

  void toggleOption(
      FilterType type,
      String id,
      ) {
    final selectedSet = getSelectedSet(type);

    // Sort By = only one selection
    if (type == FilterType.sortBy) {
      selectedSet.clear();
      selectedSet.add(id);
      return;
    }

    // Other filters = multiple selections
    if (selectedSet.contains(id)) {
      selectedSet.remove(id);
    } else {
      selectedSet.add(id);
    }
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
    final Map<FilterType, Set<String>> result = {
      FilterType.sortBy: Set<String>.from(selectedSortBy),
      FilterType.availability: Set<String>.from(selectedAvailability),
      FilterType.collections: Set<String>.from(selectedCollections),
      FilterType.length: Set<String>.from(selectedLength),
    };

    Get.back(result: result);
  }
}
