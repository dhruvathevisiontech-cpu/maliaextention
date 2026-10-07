import 'package:get/get.dart';
import 'package:maliaextention/apps/module/cartcontroller.dart';

class Viewcartcontroller extends GetxController {
  late Cartcontroller cartController;
  final RxBool isAddressSelected = false.obs;
  @override
  void onInit() {
    super.onInit();

    print("========== VIEW CART CONTROLLER ==========");

    if (Get.isRegistered<Cartcontroller>()) {
      cartController = Get.find<Cartcontroller>();

      print("[VIEW CART] Cartcontroller found ✅");
      print(
        "[VIEW CART] Cart items: ${cartController.cartItems.length}",
      );
      print(
        "[VIEW CART] Total items: ${cartController.totalItems}",
      );
    } else {
      cartController = Get.put<Cartcontroller>(
        Cartcontroller(),
        permanent: true,
      );

      print("[VIEW CART] Cartcontroller created ✅");
    }

    print("==========================================");
  }

  // + button
  void incrementQuantity(int index) {
    cartController.increaseQuantity(index);
  }

  // - button
  void decrementQuantity(int index) {
    cartController.decreaseQuantity(index);
  }

  // Delete item
  void removeItem(int index) {
    cartController.removeFromCart(index);
  }
}