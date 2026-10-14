import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/shippingpolicy/controller/shippingpolicycontroller.dart';

class Shippingpolicybinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Shippingpolicycontroller>(
      Shippingpolicycontroller(),
    );
  }
}
