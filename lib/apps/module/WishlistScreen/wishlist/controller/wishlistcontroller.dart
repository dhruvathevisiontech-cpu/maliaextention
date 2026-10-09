import 'package:get/get.dart';

class Wishlistcontroller extends GetxController {
  final RxList<Map<String, dynamic>> wishlistProducts =
      <Map<String, dynamic>>[].obs;

  void addToWishlist(Map<String, dynamic> product) {
    final productId = product["id"]?.toString();

    if (productId == null || productId.isEmpty) {
      return;
    }

    final alreadyExists = wishlistProducts.any(
          (item) => item["id"]?.toString() == productId,
    );

    if (!alreadyExists) {
      wishlistProducts.add(
        Map<String, dynamic>.from(product),
      );
    }
  }

  void removeFromWishlist(String productId) {
    wishlistProducts.removeWhere(
          (item) => item["id"]?.toString() == productId,
    );
  }

  bool isWishlisted(String productId) {
    return wishlistProducts.any(
          (item) => item["id"]?.toString() == productId,
    );
  }

  void toggleWishlist(Map<String, dynamic> product) {
    final productId = product["id"]?.toString();

    if (productId == null || productId.isEmpty) {
      return;
    }

    if (isWishlisted(productId)) {
      removeFromWishlist(productId);
    } else {
      addToWishlist(product);
    }
  }
}