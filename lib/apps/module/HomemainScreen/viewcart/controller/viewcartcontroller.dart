import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maliaextention/typo/appsnackbar.dart';
import 'package:maliaextention/apps/module/cartcontroller.dart';
class Viewcartcontroller extends GetxController {
  late Cartcontroller cartController;
  final TextEditingController promoCodeController = TextEditingController();
  final RxBool isAddressSelected = false.obs;
  final RxBool isCheckoutLoading = false.obs;
  final RxString animatingLineId = ''.obs;
  final RxBool isApplyingPromoCode = false.obs;

  final RxString appliedPromoCode = ''.obs;
  Future<void> _runQuantityAnimation(String lineId, Future<void> Function() action,) async {
    animatingLineId.value = lineId;
    try {
      await action();
    } finally {
      if (animatingLineId.value == lineId) {
        animatingLineId.value = '';
      }
    }
  }
  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<Cartcontroller>()) {
      cartController = Get.find<Cartcontroller>();
    } else {
      cartController = Get.put<Cartcontroller>(
        Cartcontroller(),
        permanent: true,
      );
    }
    cartController.debugCheckoutPlusProduct();
    cartController.debugCheckoutPlusTokenless();
    cartController.debugCheckoutPlusVariants();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await cartController.loadCart();
      await cartController.debugCompareStorefrontProducts();
    });
  }
  Future<void> refreshCart() async {
    await cartController.loadCart();
  }
  Future<void> incrementQuantity(int index) async {
    debugPrint('');
    debugPrint('========== CART UI: INCREMENT ==========');
    debugPrint('Tapped + button');
    debugPrint('Index: $index');
    debugPrint('Cart items count: ${cartController.cartItems.length}');
    if (index < 0 || index >= cartController.cartItems.length) {
      debugPrint('ERROR: Invalid cart item index');
      return;
    }
    final item = cartController.cartItems[index];
    debugPrint('Product: ${item['name']}');
    debugPrint('Line ID: ${item['lineId']}');
    debugPrint('Quantity before: ${item['quantity']}');
    await _runQuantityAnimation(
      item['lineId'].toString(),
          () => cartController.increaseQuantity(index),
    );
    if (index < cartController.cartItems.length) {
      debugPrint('Quantity after: ${cartController.cartItems[index]['quantity']}',);
    }
    debugPrint('========== INCREMENT FINISHED ==========');
  }
  Future<void> decrementQuantity(int index) async {
    debugPrint('');
    debugPrint('========== CART UI: DECREMENT ==========');
    debugPrint('Tapped - button');
    debugPrint('Index: $index');
    debugPrint('Cart items count: ${cartController.cartItems.length}');
    if (index < 0 || index >= cartController.cartItems.length) {
      debugPrint('ERROR: Invalid cart item index');
      return;
    }
    final item = cartController.cartItems[index];
    final productName = item['name']?.toString() ?? '';
    final lineId = item['lineId']?.toString() ?? '';
    final quantity = int.tryParse(item['quantity']?.toString() ?? '1',) ?? 1;
    debugPrint('Product: $productName');
    debugPrint('Line ID: $lineId');
    debugPrint('Quantity before: $quantity');
    if (quantity <= 1) {
      await _runQuantityAnimation(
        lineId,
            () => removeItem(index),
      );
    } else {
      await _runQuantityAnimation(
        lineId,
            () => cartController.decreaseQuantity(index),
      );
    }
    debugPrint('Cart items after operation: ${cartController.cartItems.length}');
    for (int i = 0; i < cartController.cartItems.length; i++) {
      debugPrint('Product: ${cartController.cartItems[i]['name']} | ''Quantity: ${cartController.cartItems[i]['quantity']}',);
    }
    debugPrint('========== DECREMENT FINISHED ==========');
  }
  Future<void> removeItem(int index) async {
    await cartController.removeFromCart(index);
  }
  Future<void> applyPromoCode() async {
    final code = promoCodeController.text.trim().toUpperCase();

    if (code.isEmpty) {
      AppSnackbar.error('Please enter a promo code.');
      return;
    }

    if (isApplyingPromoCode.value) return;

    try {
      isApplyingPromoCode.value = true;

      final success = await cartController.applyPromoCode(code);

      if (success) {
        appliedPromoCode.value = code;
        promoCodeController.clear();

        Get.snackbar(
          'Success',
          'Promo code applied successfully.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        AppSnackbar.error(
          cartController.cartError.value.isNotEmpty
              ? cartController.cartError.value
              : 'Unable to apply promo code.',
        );
      }
    } finally {
      isApplyingPromoCode.value = false;
    }
  }
  @override
  void onClose() {
    promoCodeController.dispose();
    super.onClose();
  }
  Future<void> proceedToCheckout() async {
    if (cartController.isUpdating.value) return;
    await cartController.loadCart();
    if (cartController.cartError.value.isNotEmpty) {
      AppSnackbar.error(cartController.cartError.value);
      return;
    }
    if (cartController.cartItems.isEmpty) {
      AppSnackbar.error('Please add a product before checking out.',);
      return;
    }
    final checkout = cartController.checkoutUrl.value;
    if (checkout.isEmpty) {
      AppSnackbar.error('Shopify did not return a checkout URL. Please try again.',);
      return;
    }
    final uri = Uri.tryParse(checkout);
    if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
      AppSnackbar.error('The Shopify checkout URL is invalid.',);
      return;
    }
    try {
      final opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!opened) {
        AppSnackbar.error('Unable to open Shopify checkout.');
      }
    } catch (e) {
      AppSnackbar.error('Unable to open checkout. Please try again.');
    }
  }
}