
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
    String variantId = '',
    String variantPrice = '',
    String currencyCode = 'USD',
  }) {
    final productId = product['id']?.toString() ?? '';
    final effectiveVariantId = variantId.isNotEmpty
        ? variantId
        : product['variantId']?.toString() ?? '';

    final existingIndex = cartItems.indexWhere((item) {
      final sameProduct = item['productId'] == productId;
      final sameVariant = effectiveVariantId.isNotEmpty
          ? item['variantId'] == effectiveVariantId
          : item['shade'] == shade &&
          item['length'] == length &&
          item['hairType'] == hairType;

      return sameProduct && sameVariant;
    });

    final cartProduct = <String, dynamic>{
      ...product,
      if (variantPrice.isNotEmpty) 'price': variantPrice,
      if (variantPrice.isNotEmpty) 'variantPrice': variantPrice,
      'currencyCode': currencyCode,
      if (effectiveVariantId.isNotEmpty)
        'variantId': effectiveVariantId,
    };

    if (existingIndex != -1) {
      final currentQuantity =
          (cartItems[existingIndex]['quantity'] as int?) ?? 0;

      cartItems[existingIndex]['quantity'] =
          currentQuantity + quantity;

      cartItems.refresh();
    } else {
      cartItems.add({
        'productId': productId,
        'variantId': effectiveVariantId,
        'product': cartProduct,
        'shade': shade,
        'length': length,
        'hairType': hairType,
        'quantity': quantity,
        'variantPrice': variantPrice.isNotEmpty
            ? variantPrice
            : product['price']?.toString() ?? '0.00',
        'currencyCode': currencyCode,
      });
    }

    Get.snackbar(
      'Added to Cart',
      '${product['name'] ?? 'Product'} added to your cart',
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
      final quantity = (cartItems[index]['quantity'] as int?) ?? 1;
      cartItems[index]['quantity'] = quantity + 1;
      cartItems.refresh();
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      final quantity = (cartItems[index]['quantity'] as int?) ?? 1;

      if (quantity > 1) {
        cartItems[index]['quantity'] = quantity - 1;
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
      total + ((item['quantity'] as int?) ?? 0),
    );
  }

  double get subtotal {
    return cartItems.fold(0.0, (total, item) {
      final product = item['product'] as Map<String, dynamic>? ?? {};
      final price = double.tryParse(
        item['variantPrice']?.toString() ??
            product['price']?.toString() ??
            '0',
      ) ??
          0.0;

      final quantity = (item['quantity'] as int?) ?? 0;
      return total + price * quantity;
    });
  }
}
