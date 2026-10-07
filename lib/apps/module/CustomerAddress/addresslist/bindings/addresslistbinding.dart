import 'package:get/get.dart';
import 'package:maliaextention/apps/module/CustomerAddress/addresslist/controller/addresslistcontroller.dart';
import 'package:maliaextention/apps/module/wishlist/controller/wishlistcontroller.dart';

class Addresslistbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Addresslistcontroller>(
      Addresslistcontroller(),
    );
  }
}
