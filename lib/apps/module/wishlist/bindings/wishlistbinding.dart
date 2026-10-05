import 'package:get/get.dart';
import 'package:maliaextention/apps/module/wishlist/controller/wishlistcontroller.dart';

class Wishlistbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Wishlistcontroller>(
      Wishlistcontroller(),
    );
  }
}
