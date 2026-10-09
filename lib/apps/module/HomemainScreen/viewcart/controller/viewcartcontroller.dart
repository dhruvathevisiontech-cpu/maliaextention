import 'package:get/get.dart';
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