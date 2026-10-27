
import 'package:get/get.dart';
import 'package:maliaextention/typo/appsnackbar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:maliaextention/apps/module/cartcontroller.dart';

class Viewcartcontroller extends GetxController {
  late Cartcontroller cartController;

  final RxBool isAddressSelected = false.obs;

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
    cartController.loadCart();
  }

  Future<void> refreshCart() async {
    await cartController.loadCart();
  }

  Future<void> incrementQuantity(int index) async {
    await cartController.increaseQuantity(index);
  }

  Future<void> decrementQuantity(int index) async {
    await cartController.decreaseQuantity(index);
  }

  Future<void> removeItem(int index) async {
    await cartController.removeFromCart(index);
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

    if (uri == null ||
        uri.scheme != 'https' ||
        uri.host.isEmpty) {
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
