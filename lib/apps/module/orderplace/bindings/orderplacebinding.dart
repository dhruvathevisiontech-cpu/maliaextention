import 'package:get/get.dart';
import 'package:maliaextention/apps/module/orderplace/controller/orderplacecontroller.dart';
import 'package:maliaextention/apps/module/viewcart/controller/viewcartcontroller.dart';

class Orderplacebinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Orderplacecontroller>(
      Orderplacecontroller(),
    );
  }
}
