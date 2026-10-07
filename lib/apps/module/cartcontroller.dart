import 'package:get/get.dart';

class Cartcontroller extends GetxController {
  final RxList<Map<String, dynamic>> cartItems =
      <Map<String, dynamic>>[].obs;

  void addToCart({
    required Map<String, dynamic> product,
    required String shade,
    required String length,
    required String hairType,
    required int quantity,
  }) {
    final productId = product["id"]?.toString() ?? "";

    final existingIndex = cartItems.indexWhere(
          (item) =>
      item["productId"] == productId &&
          item["shade"] == shade &&
          item["length"] == length &&
          item["hairType"] == hairType,
    );

    if (existingIndex != -1) {
      cartItems[existingIndex]["quantity"] += quantity;
      cartItems.refresh();
    } else {
      cartItems.add({
        "productId": productId,
        "product": Map<String, dynamic>.from(product),
        "shade": shade,
        "length": length,
        "hairType": hairType,
        "quantity": quantity,
      });
    }

    Get.snackbar(
      "Added to Cart",
      "${product["name"] ?? "Product"} added to your cart",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
    }
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index]["quantity"]++;
      cartItems.refresh();
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      if (cartItems[index]["quantity"] > 1) {
        cartItems[index]["quantity"]--;
        cartItems.refresh();
      }
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  int get totalItems {
    return cartItems.fold(
      0,
          (total, item) =>
      total + (item["quantity"] as int),
    );
  }
}