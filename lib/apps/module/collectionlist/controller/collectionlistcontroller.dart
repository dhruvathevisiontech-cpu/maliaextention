import 'package:get/get.dart';
import 'package:maliaextention/apps/module/wishlist/controller/wishlistcontroller.dart';

class Collectionlistcontroller extends GetxController {

  // Currently selected sub collection
  final RxInt selectedSubCollection = 0.obs;

  final Map<int, List<String>> subCollections = {

    // Collections
    0: [
      "All",
      "Butterfly Collection",
      "Genius Collection",
      "Freestyle Tape-In Collection",
      "K-Tip Collection",
      "Kyma Collection-Wavy",
      "Agápē Collection - Clip-Ins",
    ],

    // Hair Extensions
    1: [
      "All",
      "Butterfly Classic",
      "Butterfly Flutter Luxe",
      "Butterfly Skinny",
      "Butterfly Tabs",
      "Genius Weft",
      "Freestyle Tape-Ins",
      "K-Tips",
      "Shop All Extensions",
    ],

    // Accessories
    2: [
      "All",
      "Hair Tools",
      "Beads",
      "Color Bing",
      "Tool Kit",
      "Other Extension Accessories",
    ],

    // Hair Care
    3: [
      "All",
      "Shop All Hair Care",
      "The Prep-Pre-Wash",
      "The Hydrate-Luxury Shampoo",
      "The Hydrate-Luxury Conditioner",
      "The Detangler",
      "The Shine-Spray",
    ],
  };
  final Wishlistcontroller wishlistController =
  Get.find<Wishlistcontroller>();

  List<String> getSubCollections(int collectionIndex) {
    return subCollections[collectionIndex] ?? [];
  }

  void selectSubCollection(int index) {
    selectedSubCollection.value = index;

    // Later:
    // fetchProductsForSubCollection(...)
  }

  void toggleWishlist(Map<String, String> product) {
    wishlistController.toggleWishlist(
      Map<String, dynamic>.from(product),
    );
  }

  bool isWishlisted(Map<String, String> product) {
    final productId = product["id"]?.toString();

    if (productId == null || productId.isEmpty) {
      return false;
    }

    return wishlistController.isWishlisted(productId);
  }

  @override
  void onInit() {
    super.onInit();
    selectedSubCollection.value = 0;
  }
}