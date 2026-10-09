import 'package:get/get.dart';
import 'package:maliaextention/apps/module/WishlistScreen/wishlist/controller/wishlistcontroller.dart';

class Wishlistbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Wishlistcontroller>(
      Wishlistcontroller(),
    );
  }
}
