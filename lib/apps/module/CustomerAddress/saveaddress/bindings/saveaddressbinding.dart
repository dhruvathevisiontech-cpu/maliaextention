import 'package:get/get.dart';
import 'package:maliaextention/apps/module/CustomerAddress/addresslist/controller/addresslistcontroller.dart';
import 'package:maliaextention/apps/module/CustomerAddress/saveaddress/controller/saveaddresscontroller.dart';
import 'package:maliaextention/apps/module/wishlist/controller/wishlistcontroller.dart';

class Saveaddressbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Saveaddresscontroller>(
      Saveaddresscontroller(),
    );
  }
}
